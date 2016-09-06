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
                                                                     [[[STCGlobals teamDict] objectForKey:_awayTeam.teamID] abbreviation],
                                                                     _awayTeam.teamRecord,
                                                                     _awayTeam.runsScored,
                                                                     [[[STCGlobals teamDict] objectForKey:_homeTeam.teamID] abbreviation],
                                                                     _homeTeam.teamRecord,
                                                                     _homeTeam.runsScored]];
    [desc appendString:@"\nInnings:"];
    for(STCInning *inn in _innings) {
        [desc appendString:[NSString stringWithFormat:@"\n%@", inn]];
    }
         
    return desc;
}

@end
