//
//  STCTeamScoreView.h
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STCSummaryTeamView : UIView

- (void)setTeamID:(NSString *)teamID;
- (void)setScore:(NSNumber *)score;
- (void)setTeamWon:(BOOL)won;

@end
