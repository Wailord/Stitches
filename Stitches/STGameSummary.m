//
//  STGameSummary.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGameSummary.h"

@implementation STGameSummary

@synthesize homeScore;
@synthesize homeTeam;
@synthesize awayScore;
@synthesize awayTeam;
@synthesize topOfInning;
@synthesize inning;

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@) @ %@ (%@)",
            self.awayTeam,
            self.awayScore,
            self.homeTeam,
            self.homeScore];
}

@end
