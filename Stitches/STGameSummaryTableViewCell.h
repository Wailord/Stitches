//
//  STGameSummaryTableViewCell.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STConstants.h"
#import "STGameSummary.h"

@interface STGameSummaryTableViewCell : UITableViewCell {
    @private
    UIImageView *_awayLogo;
    UIImageView *_homeLogo;
    UILabel *_homeScoreLabel;
    UILabel *_homeNameLabel;
    UILabel *_awayScoreLabel;
    UILabel *_awayNameLabel;
    UILabel *_statusLabel;
}

@property NSNumber *homeScore;
@property NSString *homeName;
@property NSNumber *awayScore;
@property NSString *awayName;
@property NSNumber *inning;

- (id)initWithGame:(STGameSummary *)game;

@end
