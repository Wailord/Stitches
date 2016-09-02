//
//  STParseMLB.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STParserMLB.h"

@implementation STParserMLB {
    NSXMLParser *_summaryParser;
    NSXMLParser *_previewParser;
    NSMutableArray *_summaryList;
    STGameSummary *_summary;
    STGamePreview *_preview;
}

-(void)parsePreviewWithGameID:(NSString *)gameID {
    NSArray *components = [gameID componentsSeparatedByString:@"/"];
    NSString *year = components[0];
    NSString *month = components[1];
    NSString *date = components[2];
    NSMutableString *gID = [[NSMutableString alloc] initWithString:components[3]];
    [gID replaceOccurrencesOfString:@"-"
                         withString:@"_"
                            options:NSLiteralSearch
                              range:NSMakeRange(0,[components[3] length])];
    NSString *xmlPath = [NSString stringWithFormat:@"http://gd2.mlb.com/components/game/mlb/year_%@/month_%@/day_%@/gid_%@_%@_%@_%@/linescore.xml",
                         year,
                         month,
                         date,
                         year,
                         month,
                         date,
                         gID];
    NSURL *url = [[NSURL alloc] initWithString:xmlPath];
    
    // set up and start up the XML parser
    _previewParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [_previewParser setDelegate:self];
    [_previewParser parse];
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
    _summaryParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [_summaryParser setDelegate:self];
    [_summaryParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if(parser == _summaryParser) {
        // once we find some games, initialize our mutable array of games
        if([elementName isEqualToString:@"games"]) {
            _summaryList = [[NSMutableArray alloc] init];
        }
        else if([elementName isEqualToString:@"game"])
        {
            // check to see if the game has a status that is currently supported
            bool validGame = false;
            enum STGameStatus status = NoStatus;
            if([[attributeDict objectForKey:@"status"] isEqualToString:@"In Progress"]) {
                status = InProgress;
                validGame = true;
            }
            else if([[attributeDict objectForKey:@"status"] isEqualToString:@"Preview"]) {
                status = Preview;
                validGame = true;
            }
            else if([[attributeDict objectForKey:@"status"] isEqualToString:@"Final"]) {
                status = Final;
                validGame = true;
            }
            
            // so long as we support the game status, we can init and start building a new game summary
            if(validGame) {
                _summary = [[STGameSummary alloc] init];
                _summary.status = status;
                
                // get the game id
                _summary.gameID = [attributeDict objectForKey:@"id"];
                
                // get the current score
                _summary.awayScore = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_team_runs"] integerValue]];
                _summary.homeScore = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_team_runs"] integerValue]];
                
                // get the teams playing
                _summary.homeTeamID = [attributeDict objectForKey:@"home_team_id"];
                _summary.awayTeamID = [attributeDict objectForKey:@"away_team_id"];
                
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
    else if(parser == _previewParser) {
        if([elementName isEqualToString:@"game"]) {
            _preview = [[STGamePreview alloc] init];
        }
        else if([elementName isEqualToString:@"home_probable_pitcher"]) {
            NSString *firstName = [attributeDict objectForKey:@"first_name"];
            NSString *lastName = [attributeDict objectForKey:@"last_name"];
            _preview.homeProbablePitcher = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        }
        else if([elementName isEqualToString:@"away_probable_pitcher"]) {
            NSString *firstName = [attributeDict objectForKey:@"first_name"];
            NSString *lastName = [attributeDict objectForKey:@"last_name"];
            _preview.awayProbablePitcher = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        }
    }
    else {
        NSLog(@"ERROR: An unidentified parser is parsing");
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if(parser == _summaryParser) {
        if([elementName isEqualToString:@"game"] && _summary != nil) {
            [_summaryList addObject:_summary];
            if(_summaryDelegate) {
                [_summaryDelegate parsedGameSummary:_summary];
            }
            _summary = nil;
        }
        else if([elementName isEqualToString:@"games"]) {
            if(_summaryDelegate) {
                [_summaryDelegate parsedAllGameSummaries];
            }
        }
    }
    else if(parser == _previewParser) {
        if([elementName isEqualToString:@"game"] && _preview != nil) {
            if(_previewDelegate) {
                [_previewDelegate parsedGamePreview:_preview];
            }
            _preview = nil;
        }
    }
}
@end
