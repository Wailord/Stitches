//
//  STGameSummary.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGameSummary.h"
#import "STConstants.h"

@implementation STGameSummary

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@) @ %@ (%@)",
            [[STConstants teamDict] valueForKeyPath:[NSString stringWithFormat:@"%@.abbrev", self.awayTeamID]],
            self.awayScore,
            [[STConstants teamDict] valueForKeyPath:[NSString stringWithFormat:@"%@.abbrev", self.homeTeamID]],
            self.homeScore];
}

@end
