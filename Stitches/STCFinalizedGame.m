//
//  STCFinalizedGame.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedGame.h"

@implementation STCFinalizedGame

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@) vs. %@ (%@)",
            [[[STCGlobals teamDict] objectForKey:_awayTeamID] abbreviation],
            _awayTeamScore,
            [[[STCGlobals teamDict] objectForKey:_homeTeamID] abbreviation],
            _homeTeamScore];
}

@end
