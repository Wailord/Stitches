//
//  STGameSummary.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCBaseGame.h"
#import "STCGlobals.h"

@implementation STCBaseGame

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        _awayTeam = [STCBaseTeam new];
        _homeTeam = [STCBaseTeam new];
        
        // check to see if the game has a status that is currently supported
        bool validGame = false;
        enum STCGameStatus status = STCNoStatus;
        if([dict[@"status"] isEqualToString:@"In Progress"]) {
            status = STCInProgressStatus;
            validGame = true;
        }
        else if([dict[@"status"] isEqualToString:@"Preview"] || [dict[@"status"] isEqualToString:@"Pre-Game"]) {
            status = STCPreviewStatus;
            validGame = true;
        }
        else if([dict[@"status"] isEqualToString:@"Final"]) {
            status = STCFinalizedStatus;
            validGame = true;
        }
        
        // so long as we support the game status, we can init and start building a new game summary
        if(validGame) {
            _status = status;
            
            // get the game id
            _gameID = dict[@"id"];
            
            //NSLog(@"Game ID: %@", _gameID);
            
            // get the current score
            _awayTeam.runsScored = @([dict[@"away_team_runs"] integerValue]);
            _homeTeam.runsScored = @([dict[@"home_team_runs"] integerValue]);
            
            // get the teams playing
            _homeTeam.teamID = dict[@"home_team_id"];
            _awayTeam.teamID = dict[@"away_team_id"];
            
            // set the records
            _awayTeam.teamRecord.wins =@([dict[@"away_win"] integerValue]);
            _awayTeam.teamRecord.losses =@([dict[@"away_loss"] integerValue]);
            _homeTeam.teamRecord.wins =@([dict[@"home_win"] integerValue]);
            _homeTeam.teamRecord.losses =@([dict[@"home_loss"] integerValue]);
            
            // get the inning info
            _inning = @([dict[@"inning"] integerValue]);
            _topOfInning = [dict[@"top_of_inning"] isEqualToString:@"Y"];
            
            // start setting up time info; we need to check both the time zone and am/pm
            NSString *timeZone = dict[@"time_zone"];
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
            NSDate *dte = [dateFormat dateFromString:dict[@"time_date"]];
            
            // if MLB says the time was in PM, we need to add twelve hours to the time
            if([dict[@"ampm"] isEqualToString:@"PM"]) {
                // add twelve hours for PM
                NSTimeInterval twelveHours = 12 * 60 * 60;
                dte = [dte dateByAddingTimeInterval:twelveHours];
            }
            
            // assign the start time after building the date
            _startTime = dte;
        }
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@) @ %@ (%@)",
            [STCGlobals abbreviationForTeamID:_awayTeam.teamID],
            self.awayTeam.runsScored,
            [STCGlobals abbreviationForTeamID:_homeTeam.teamID],
            self.homeTeam.runsScored];
}

@end
