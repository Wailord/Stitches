//
//  STCLinescoreView.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCLinescoreInningLabel.h"

@interface STCLinescoreView : UIView

@property NSMutableArray *titleInningLabels;
@property NSMutableArray *awayInningLabels;
@property NSMutableArray *homeInningLabels;

@property STCLinescoreInningLabel *awayHitsLabel;
@property STCLinescoreInningLabel *homeHitsLabel;
@property STCLinescoreInningLabel *awayScoreLabel;
@property STCLinescoreInningLabel *homeScoreLabel;
@property STCLinescoreInningLabel *awayErrorsLabel;
@property STCLinescoreInningLabel *homeErrorsLabel;
@property STCLinescoreInningLabel *awayTeamLabel;
@property STCLinescoreInningLabel *homeTeamLabel;

@end
