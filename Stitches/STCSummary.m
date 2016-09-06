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

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@) @ %@ (%@)",
            [STCGlobals getAbbreviationForTeamID:_awayTeamID],
            self.awayScore,
            [STCGlobals getAbbreviationForTeamID:_homeTeamID],
            self.homeScore];
}

@end
