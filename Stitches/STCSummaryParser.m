//
//  STParseMLB.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummaryParser.h"

@interface STCSummaryParser ()<NSXMLParserDelegate>
@end

@implementation STCSummaryParser {
    NSXMLParser *_parser;
    NSMutableArray *_summaryList;
    STCBaseGame *_summary;
}

-(void)parseGameSummariesForYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day{
    // if our month or date is less than ten, make sure the string prepends a zero (so each is always two characters)
    NSString *monthString = (month < 10) ? [NSString stringWithFormat:@"0%ld", (long)month] : [NSString stringWithFormat:@"%ld", (long)month];
    NSString *dateString = (day < 10) ? [NSString stringWithFormat:@"0%@", @(day)] : @(day).stringValue;
    
    // build the URL we're going to use to get current MLB scoreboard info
    NSString *xmlPath = [NSString stringWithFormat:@"http://gd2.mlb.com/components/game/mlb/year_%ld/month_%@/day_%@/miniscoreboard.xml",
                         (long)year,
                         monthString,
                         dateString];
    
    NSURL *url = [[NSURL alloc] initWithString:xmlPath];
    
    // set up and start up the XML parser
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    _parser.delegate = self;
    [_parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // once we find some games, initialize our mutable array of games
    if([elementName isEqualToString:@"games"]) {
        _summaryList = [NSMutableArray new];
    }
    else if([elementName isEqualToString:@"game"])
    {
        // check to see if the game has a status that is currently supported
        bool validGame = false;
        enum STCGameStatus status = STCNoStatus;
        if([attributeDict[@"status"] isEqualToString:@"In Progress"]) {
            status = STCInProgressStatus;
            validGame = true;
        }
        else if([attributeDict[@"status"] isEqualToString:@"Preview"] || [attributeDict[@"status"] isEqualToString:@"Pre-Game"]) {
            status = STCPreviewStatus;
            validGame = true;
        }
        else if([attributeDict[@"status"] isEqualToString:@"Final"]) {
            status = STCFinalizedStatus;
            validGame = true;
        }
        
        // so long as we support the game status, we can init and start building a new game summary
        if(validGame) {
            _summary = [STCBaseGame new];
            _summary.status = status;
            
            // get the game id
            _summary.gameID = attributeDict[@"id"];
            
            //NSLog(@"Game ID: %@", _summary.gameID);
            
            // get the current score
            _summary.awayTeam.runsScored = @([attributeDict[@"away_team_runs"] integerValue]);
            _summary.homeTeam.runsScored = @([attributeDict[@"home_team_runs"] integerValue]);
            
            // get the teams playing
            _summary.homeTeam.teamID = attributeDict[@"home_team_id"];
            _summary.awayTeam.teamID = attributeDict[@"away_team_id"];
            
            // set the records
            _summary.awayTeam.teamRecord.wins =@([attributeDict[@"away_win"] integerValue]);
            _summary.awayTeam.teamRecord.losses =@([attributeDict[@"away_loss"] integerValue]);
            _summary.homeTeam.teamRecord.wins =@([attributeDict[@"home_win"] integerValue]);
            _summary.homeTeam.teamRecord.losses =@([attributeDict[@"home_loss"] integerValue]);
            
            // get the inning info
            _summary.inning = @([attributeDict[@"inning"] integerValue]);
            _summary.topOfInning = [attributeDict[@"top_of_inning"] isEqualToString:@"Y"];
            
            // start setting up time info; we need to check both the time zone and am/pm
            NSString *timeZone = attributeDict[@"time_zone"];
            NSDateFormatter *dateFormat = [NSDateFormatter new];
            dateFormat.dateFormat = @"YYYY/MM/dd hh:mm";
            if([timeZone isEqualToString:@"ET"]) {
                dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EDT"];
            }
            else if([timeZone isEqualToString:@"PT"]) {
                dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"PDT"];
            }
            else if([timeZone isEqualToString:@"CT"]) {
                dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"CDT"];
            }
            
            // with the time zone set up, we can build the date
            NSDate *dte = [dateFormat dateFromString:attributeDict[@"time_date"]];
            
            // if MLB says the time was in PM, we need to add twelve hours to the time
            if([attributeDict[@"ampm"] isEqualToString:@"PM"]) {
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
