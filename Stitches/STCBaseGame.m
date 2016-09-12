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

- (instancetype)init {
    self = [super init];
    if(self) {
        _awayTeam = [[STCBaseTeam alloc] init];
        _homeTeam = [[STCBaseTeam alloc] init];
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
