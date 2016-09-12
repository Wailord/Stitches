//
//  STParseMLB.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummaryParser.h"

@implementation STCSummaryParser {
    NSXMLParser *_parser;
    NSMutableArray *_summaryList;
    STCBaseGame *_summary;
}

-(void)parseGameSummariesForYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day{
    // if our month or date is less than ten, make sure the string prepends a zero (so each is always two characters)
    NSString *monthS = (month < 10) ? [NSString stringWithFormat:@"0%ld", (long)month] : [NSString stringWithFormat:@"%ld", (long)month];
    NSString *dateS = (day < 10) ? [NSString stringWithFormat:@"0%ld", (long)day] : [NSString stringWithFormat:@"%ld", (long)day];
    
    // build the URL we're going to use to get current MLB scoreboard info
    NSString *xmlPath = [NSString stringWithFormat:@"http://gd2.mlb.com/components/game/mlb/year_%ld/month_%@/day_%@/miniscoreboard.xml",
                         (long)year,
                         monthS,
                         dateS];
    NSURL *url = [[NSURL alloc] initWithString:xmlPath];
    
    // set up and start up the XML parser
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [_parser setDelegate:self];
    [_parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // once we find some games, initialize our mutable array of games
    if([elementName isEqualToString:@"games"]) {
        _summaryList = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"game"])
    {
        // check to see if the game has a status that is currently supported
        bool validGame = false;
        enum STCGameStatus status = STCNoStatus;
        if([[attributeDict objectForKey:@"status"] isEqualToString:@"In Progress"]) {
            status = STCInProgressStatus;
            validGame = true;
        }
        else if([[attributeDict objectForKey:@"status"] isEqualToString:@"Preview"] || [[attributeDict objectForKey:@"status"] isEqualToString:@"Pre-Game"]) {
            status = STCPreviewStatus;
            validGame = true;
        }
        else if([[attributeDict objectForKey:@"status"] isEqualToString:@"Final"]) {
            status = STCFinalizedStatus;
            validGame = true;
        }
        
        // so long as we support the game status, we can init and start building a new game summary
        if(validGame) {
            _summary = [[STCBaseGame alloc] init];
            _summary.status = status;
            
            // get the game id
            _summary.gameID = [attributeDict objectForKey:@"id"];
            
            //NSLog(@"Game ID: %@", _summary.gameID);
            
            // get the current score
            _summary.awayTeam.runsScored = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_team_runs"] integerValue]];
            _summary.homeTeam.runsScored = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_team_runs"] integerValue]];
            
            // get the teams playing
            _summary.homeTeam.teamID = [attributeDict objectForKey:@"home_team_id"];
            _summary.awayTeam.teamID = [attributeDict objectForKey:@"away_team_id"];
            
            // set the records
            _summary.awayTeam.teamRecord.wins =[NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_win"] integerValue]];
            _summary.awayTeam.teamRecord.losses =[NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_loss"] integerValue]];
            _summary.homeTeam.teamRecord.wins =[NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_win"] integerValue]];
            _summary.homeTeam.teamRecord.losses =[NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_loss"] integerValue]];
            
            // get the inning info
            _summary.inning = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"inning"] integerValue]];
            _summary.topOfInning = [[attributeDict objectForKey:@"top_of_inning"] isEqualToString:@"Y"];
            
            // start setting up time info; we need to check both the time zone and am/pm
            NSString *timeZone = [attributeDict objectForKey:@"time_zone"];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY/MM/dd hh:mm"];
            if([timeZone isEqualToString:@"ET"]) {
                [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EDT"]];
            }
            else if([timeZone isEqualToString:@"PT"]) {
                [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PDT"]];
            }
            else if([timeZone isEqualToString:@"CT"]) {
                [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CDT"]];
            }
            
            // with the time zone set up, we can build the date
            NSDate *dte = [dateFormat dateFromString:[attributeDict objectForKey:@"time_date"]];
            
            // if MLB says the time was in PM, we need to add twelve hours to the time
            if([[attributeDict objectForKey:@"ampm"] isEqualToString:@"PM"]) {
                // add twelve hours for PM
                NSTimeInterval twelveHours = 12 * 60 * 60;
                dte = [dte dateByAddingTimeInterval:twelveHours];
            }
            
            // assign the start time after building the date
            _summary.startTime = dte;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if(parser == _parser) {
        if([elementName isEqualToString:@"game"] && _summary != nil) {
            [_summaryList addObject:_summary];
            if(self.delegate) {
                [self.delegate parsedGameSummary:_summary];
            }
            _summary = nil;
        }
        else if([elementName isEqualToString:@"games"]) {
            if(self.delegate) {
                [self.delegate parsedAllGameSummaries];
            }
        }
    }
}
@end
