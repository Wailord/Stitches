//
//  STCTeamScoreView.h
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STCSummaryTeamView : UIView

@property UIImageView *teamLogoImageView;
@property UILabel *teamNameLabel;
@property UILabel *teamScoreLabel;

-(instancetype)initWithTeamID:(NSString *)teamID andScore:(NSNumber *)score andWon:(bool)won;

@end
