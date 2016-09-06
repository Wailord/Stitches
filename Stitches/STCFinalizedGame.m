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
        _innings = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSString *)description {
    NSMutableString *desc = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@ (%@) vs. %@ (%@)",
                                                                     [[[STCGlobals teamDict] objectForKey:_awayTeamID] abbreviation],
                                                                     _awayTeamScore,
                                                                     [[[STCGlobals teamDict] objectForKey:_homeTeamID] abbreviation],
                                                                     _homeTeamScore]];
    [desc appendString:@"\nInnings:"];
    for(STCInning *inn in _innings) {
        [desc appendString:[NSString stringWithFormat:@"\n%@", inn]];
    }
         
    return desc;
}

@end
