//
//  STGamePreview.h
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCPreviewPitcher.h"

@interface STCPreview : NSObject

@property NSString *awayTeamID;
@property STCPreviewPitcher *awayProbablePitcher;
@property NSString *homeTeamID;
@property STCPreviewPitcher *homeProbablePitcher;

@end
