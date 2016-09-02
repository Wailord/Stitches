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
            [[[STCGlobals teamDict] objectForKey:self.awayTeamID] abbreviation],
            self.awayScore,
            [[[STCGlobals teamDict] objectForKey:self.homeTeamID] abbreviation],
            self.homeScore];
}

@end
