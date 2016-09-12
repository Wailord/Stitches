//
//  STGameSummary.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummary.h"
#import "STCGlobals.h"

@implementation STCSummary

- (instancetype)init {
    self = [super init];
    if(self) {
        _awayTeam = [[STCSummaryTeam alloc] init];
        _homeTeam = [[STCSummaryTeam alloc] init];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@) @ %@ (%@)",
            [STCGlobals getAbbreviationForTeamID:_awayTeam.teamID],
            self.awayTeam.runsScored,
            [STCGlobals getAbbreviationForTeamID:_homeTeam.teamID],
            self.homeTeam.runsScored];
}

@end
