//
//  STCFinalizedTeamView.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STCFinalizedTeamView : UIView

- (void)setTeamNameText:(NSString *)text;
- (void)setRunsScoredText:(NSString *)text;
- (void)setTeamLogoWithID:(NSString *)teamID;
- (void)setTeamInfoText:(NSString *)text;

@end
