//
//  STGamePreview.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreview.h"
#import "STCPitcher.h"

@implementation STCPreview

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        _awayTeam = [STCPreviewTeam new];
        _homeTeam = [STCPreviewTeam new];
        _awayTeam.teamID = dict[@"away_team_id"];
        _homeTeam.teamID = dict[@"home_team_id"];
        _awayTeam.teamRecord.wins = @([dict[@"away_win"] integerValue]);
        _awayTeam.teamRecord.losses = @([dict[@"away_loss"] integerValue]);
        _homeTeam.teamRecord.wins = @([dict[@"home_win"] integerValue]);
        _homeTeam.teamRecord.losses = @([dict[@"home_loss"] integerValue]);
        
        // venue
        STCVenue *venue = [STCVenue new];
        venue.venueID = dict[@"venue_id"];
        venue.name = dict[@"venue"];
        venue.location = dict[@"location"];
        _venue = venue;
        
        if(dict[@"time_date"]) {
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

-(NSString *)description {
    return [NSString stringWithFormat:@"AWAY PROBABLE: %@; HOME PROBABLE: %@",
            self.awayTeam.probablePitcher,
            self.homeTeam.probablePitcher];
}

@end
