//
//  STCFinalizedView.h
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STCFinalizedView : UIView

- (void)setAwayTeamNameText:(NSString *)text;
- (void)setHomeTeamNameText:(NSString *)text;
- (void)setAwayTeamInfoText:(NSString *)text;
- (void)setHomeTeamInfoText:(NSString *)text;
- (void)setAwayRunsScoredText:(NSString *)text;
- (void)setHomeRunsScoredText:(NSString *)text;
- (void)setAwayTeamLogoWithID:(NSString *)teamID;
- (void)setHomeTeamLogoWithID:(NSString *)teamID;
- (void)setLinescoreWithAwayScore:(NSString *)awayScore
                     andHomeScore:(NSString *)homeScore
                     andAwayHits:(NSString *)awayHits
                     andHomeHits:(NSString *)homeHits
                   andAwayErrors:(NSString *)awayErrors
                   andHomeErrors:(NSString *)homeErrors
                andAwayTeamLabel:(NSString *)awayLabel
                andHomeTeamLabel:(NSString *)homeLabel;
- (void)setLinescoreWithInnings:(NSMutableArray *)innings;
- (void)setWinningPitcherText:(NSString *)text;
- (void)setLosingPitcherText:(NSString *)text;
- (void)setSavingPitcherText:(NSString *)text;

@end
