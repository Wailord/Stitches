//
//  STCFinalizedGame.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedGame.h"
#import "STCGlobals.h"
#import "STCInning.h"
#import "STCPitcher.h"

@implementation STCFinalizedGame

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        _awayTeam = [[STCFinalizedTeam alloc] init];
        _homeTeam = [[STCFinalizedTeam alloc] init];
        _innings = [[NSMutableArray alloc] init];
        
        _awayTeam.teamID = dict[@"away_team_id"];
        _homeTeam.teamID = dict[@"home_team_id"];
        
        // runs scored
        _awayTeam.runsScored = [NSNumber numberWithInteger:[dict[@"away_team_runs"] integerValue]];
        _homeTeam.runsScored = [NSNumber numberWithInteger:[dict[@"home_team_runs"] integerValue]];
        
        // winner
        _awayTeamWon = (_awayTeam.runsScored > _homeTeam.runsScored);
        
        // team records
        _awayTeam.teamRecord.wins = dict[@"away_win"];
        _awayTeam.teamRecord.losses = dict[@"away_loss"];
        _homeTeam.teamRecord.wins = dict[@"home_win"];
        _homeTeam.teamRecord.losses = dict[@"home_loss"];
        
        // hits
        _awayTeam.hits = [NSNumber numberWithInteger:[dict[@"away_team_hits"] integerValue]];
        _homeTeam.hits = [NSNumber numberWithInteger:[dict[@"home_team_hits"] integerValue]];
        
        // errors
        _awayTeam.errors = [NSNumber numberWithInteger:[dict[@"away_team_errors"] integerValue]];
        _homeTeam.errors = [NSNumber numberWithInteger:[dict[@"home_team_errors"] integerValue]];
        
        // venue
        STCVenue *venue = [[STCVenue alloc] init];
        venue.venueID = dict[@"venue_id"];
        venue.name = dict[@"venue"];
        venue.location = dict[@"location"];
        _venue = venue;

    }
    
    return self;
}

- (NSString *)description {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@) [%@] vs. %@ (%@) [%@]",
                                                                     [STCGlobals abbreviationForTeamID:_awayTeam.teamID],
                                                                     _awayTeam.teamRecord,
                                                                     _awayTeam.runsScored,
                                                                     [STCGlobals abbreviationForTeamID:_awayTeam.teamID],
                                                                     _homeTeam.teamRecord,
                                                                     _homeTeam.runsScored]];
    [desc appendString:@"\nInnings:"];
    for(STCInning *inn in _innings) {
        [desc appendString:[NSString stringWithFormat:@"\n%@", inn]];
    }
    
    [desc appendString:[NSString stringWithFormat:@"\nWP: %@", _winningPitcher]];
    [desc appendString:[NSString stringWithFormat:@"\nLP: %@", _losingPitcher]];
    
    if(_savingPitcher) {
        [desc appendString:[NSString stringWithFormat:@"\nSV: %@", _savingPitcher]];
    }
         
    return desc;
}

@end
