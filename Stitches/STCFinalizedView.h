//
//  STCFinalizedView.h
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCFinalizedTeamView.h"
#import "STCLinescoreView.h"
#import "STCFinalizedGame.h"

@interface STCFinalizedView : UIView

@property STCFinalizedTeamView *awayTeamView;
@property STCFinalizedTeamView *homeTeamView;
@property STCLinescoreView *linescoreView;
@property UILabel *winningPitcherLabel;
@property UILabel *losingPitcherLabel;
@property UILabel *savingPitcherLabel;

- (void)setLinescoreWithInnings:(NSMutableArray *)innings;
- (void)setGame:(STCFinalizedGame*)game;

@end
