//
//  STCFinalizedTeam.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCTeamRecord.h"

@interface STCFinalizedTeam : NSObject

@property NSString *teamID;
@property NSNumber *runsScored;
@property NSNumber *hits;
@property NSNumber *errors;
@property STCTeamRecord *teamRecord;

@end
