//
//  STCPreviewView.h
//  Stitches
//
//  Created by Ryan Fox on 9/9/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCGlobals.h"
#import "STCPreviewTeamView.h"

@interface STCPreviewView : UIView

@property STCPreviewTeamView *awayPreviewTeamView;
@property STCPreviewTeamView *homePreviewTeamView;
@property UILabel *versusLabel;
@property UILabel *venueLabel;
@property UILabel *locationLabel;
@property UILabel *startTimeLabel;

@end
