//
//  STGameSummary.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCGlobals.h"
#import "STCBaseTeam.h"

@interface STCBaseGame : NSObject

@property NSString *gameID;
@property STCBaseTeam *awayTeam;
@property STCBaseTeam *homeTeam;

@property NSNumber *inning;
@property BOOL topOfInning;

@property enum STCGameStatus status;
@property NSDate *startTime;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end