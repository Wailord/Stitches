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

- (instancetype)init {
    self = [super init];
    if(self) {
        _awayTeam = [[STCFinalizedTeam alloc] init];
        _homeTeam = [[STCFinalizedTeam alloc] init];
        _innings = [[NSMutableArray alloc] init];
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
