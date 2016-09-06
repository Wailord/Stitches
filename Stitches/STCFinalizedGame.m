//
//  STCFinalizedGame.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedGame.h"

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
                                                                     [STCGlobals getAbbreviationForTeamID:_awayTeam.teamID],
                                                                     _awayTeam.teamRecord,
                                                                     _awayTeam.runsScored,
                                                                     [STCGlobals getAbbreviationForTeamID:_awayTeam.teamID],
                                                                     _homeTeam.teamRecord,
                                                                     _homeTeam.runsScored]];
    [desc appendString:@"\nInnings:"];
    for(STCInning *inn in _innings) {
        [desc appendString:[NSString stringWithFormat:@"\n%@", inn]];
    }
         
    return desc;
}

@end
