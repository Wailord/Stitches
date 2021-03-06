//
//  STCSummaryTeam.h
//  Stitches
//
//  Created by Ryan Fox on 9/12/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCTeamRecord.h"

@interface STCBaseTeam : NSObject

@property NSString *teamID;
@property NSNumber *runsScored;
@property STCTeamRecord *teamRecord;

@end
