//
//  STGameSummary.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface STGameSummary : NSObject

@property NSString *awayTeam;
@property NSNumber *awayScore;
@property NSString *homeTeam;
@property NSNumber *homeScore;

@property NSNumber *inning;
@property BOOL topOfInning;

@property STGameStatus status;
@property NSDate *startTime;

@end
