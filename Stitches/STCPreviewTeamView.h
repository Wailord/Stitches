//
//  STCPreviewView.h
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCPreviewTeam.h"

@interface STCPreviewTeamView : UIView

@property UIImageView *teamLogoView;
@property UILabel *teamNameLabel;
@property UILabel *teamRecordLabel;
@property UIView *pitcherCardBackgroundView;
@property UIImageView *pitcherImageView;
@property UILabel *pitcherNameLabel;
@property UILabel *pitcherRecordLabel;
@property UILabel *pitcherERALabel;

- (void)setTeam:(STCPreviewTeam *)team;

@end
