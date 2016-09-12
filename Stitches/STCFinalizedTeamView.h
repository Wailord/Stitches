//
//  STCFinalizedTeamView.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCFinalizedTeam.h"

@interface STCFinalizedTeamView : UIView

@property UIImageView *teamLogoImageView;
@property UILabel *runsScoredLabel;
@property UILabel *teamNameLabel;
@property UILabel *teamInfoLabel;

- (void)setTeam:(STCFinalizedTeam*)team;

@end
