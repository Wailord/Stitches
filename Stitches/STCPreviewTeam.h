//
//  STCPreviewTeam.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCPreviewPitcher.h"
#import "STCTeamRecord.h"

@interface STCPreviewTeam : NSObject

@property NSString *teamID;
@property STCPreviewPitcher *probablePitcher;
@property STCTeamRecord *teamRecord;

@end
