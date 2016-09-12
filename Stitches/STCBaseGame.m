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
        _awayTeam = [STCBaseTeam new];
        _homeTeam = [STCBaseTeam new];
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
