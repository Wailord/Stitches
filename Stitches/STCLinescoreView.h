//
//  STCLinescoreView.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STCLinescoreView : UIView

@property (nonatomic) NSMutableArray<UILabel*> *titleInningLabels;
@property (nonatomic) NSMutableArray<UILabel*> *awayInningLabels;
@property (nonatomic) NSMutableArray<UILabel*> *homeInningLabels;

@property UILabel *awayHitsLabel;
@property UILabel *homeHitsLabel;

@property UILabel *awayScoreLabel;
@property UILabel *homeScoreLabel;

@property UILabel *awayErrorsLabel;
@property UILabel *homeErrorsLabel;

@property UILabel *awayTeamLabel;
@property UILabel *homeTeamLabel;

@end
