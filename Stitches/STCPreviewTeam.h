//
//  STCPreviewTeam.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCPitcher.h"
#import "STCTeamRecord.h"

@interface STCPreviewTeam : NSObject

@property NSString *teamID;
@property STCPitcher *probablePitcher;
@property STCTeamRecord *teamRecord;

@end
