//
//  STGameSummaryTableViewCell.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCBaseGame.h"

@interface STCSummaryTableViewCell : UITableViewCell;

@property (nonatomic) NSNumber *homeScore;
@property NSString *homeName;
@property NSNumber *awayScore;
@property NSString *awayName;
@property NSNumber *inning;

- (id)initWithGame:(STCBaseGame *)game;

@end
