//
//  STGameSummary.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCGlobals.h"
#import "STCSummaryTeam.h"

@interface STCSummary : NSObject

@property NSString *gameID;
@property STCSummaryTeam *awayTeam;
@property STCSummaryTeam *homeTeam;

@property NSNumber *inning;
@property BOOL topOfInning;

@property enum STCGameStatus status;
@property NSDate *startTime;

@end