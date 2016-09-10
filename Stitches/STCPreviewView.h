//
//  STCPreviewView.h
//  Stitches
//
//  Created by Ryan Fox on 9/9/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCGlobals.h"

@interface STCPreviewView : UIView

- (void)setTeamLogoForID:(NSString *)teamID forTeamType:(STCTeamType)type;
- (void)setTeamNameText:(NSString *)teamName forTeamType:(STCTeamType)type;
- (void)setTeamRecordText:(NSString *)recordText forTeamType:(STCTeamType)type;
- (void)setProbablePitcherNameText:(NSString *)text forTeamType:(STCTeamType)type;
- (void)setProbablePitcherERAText:(NSString *)text forTeamType:(STCTeamType)type;
- (void)setProbablePitcherRecordText:(NSString *)text forTeamType:(STCTeamType)type;
- (void)setProbablePitcherImageForID:(NSNumber *)playerID forTeamType:(STCTeamType)type;

- (void)setVenueText:(NSString *)text;
- (void)setLocationText:(NSString *)text;
- (void)setStartTimeTextWithDate:(NSDate *)startTime;

@end
