//
//  STCFinalizedView.m
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedView.h"
#import "STCFinalizedTeamView.h"
#import "STCLinescoreView.h"
#import "STCInning.h"

@implementation STCFinalizedView {
    STCFinalizedTeamView *_awayTeamView;
    STCFinalizedTeamView *_homeTeamView;
    STCLinescoreView *_linescoreView;
    UILabel *_winningPitcherLabel;
    UILabel *_losingPitcherLabel;
    UILabel *_savingPitcherLabel;
}

- (instancetype)init {
    self = [super init];
    
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _winningPitcherLabel = [[UILabel alloc] init];
        _winningPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _winningPitcherLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_winningPitcherLabel];
        
        _losingPitcherLabel = [[UILabel alloc] init];
        _losingPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _losingPitcherLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_losingPitcherLabel];
        
        _savingPitcherLabel = [[UILabel alloc] init];
        _savingPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _savingPitcherLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_savingPitcherLabel];
        
        // set up the UI elements
        _awayTeamView = [[STCFinalizedTeamView alloc] init];
        _awayTeamView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_awayTeamView];
        
        _homeTeamView = [[STCFinalizedTeamView alloc] init];
        _homeTeamView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_homeTeamView];
        
        _linescoreView = [[STCLinescoreView alloc] init];
        _linescoreView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_linescoreView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_awayTeamView, _homeTeamView,_linescoreView,
                                                             _winningPitcherLabel, _losingPitcherLabel, _savingPitcherLabel);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayTeamView]-(>=20)-[_homeTeamView]-|"
                                                                           options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                           metrics:nil
                                                                             views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_savingPitcherLabel]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_losingPitcherLabel]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_linescoreView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_winningPitcherLabel]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_awayTeamView]-[_winningPitcherLabel]-[_losingPitcherLabel]-[_savingPitcherLabel]-[_linescoreView]-(>=3)-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
    }
    
    return self;
}

- (void)setAwayTeamNameText:(NSString *)text {
    _awayTeamView.teamNameLabel.text = text;
}

- (void)setHomeTeamNameText:(NSString *)text {
    _homeTeamView.teamNameLabel.text = text;
}

- (void)setAwayTeamInfoText:(NSString *)text {
    _awayTeamView.teamInfoLabel.text = text;
}

- (void)setHomeTeamInfoText:(NSString *)text {
    _homeTeamView.teamInfoLabel.text = text;
}

- (void)setAwayRunsScoredText:(NSString *)text; {
    _awayTeamView.runsScoredLabel.text = text;
}

- (void)setHomeRunsScoredText:(NSString *)text {
    _homeTeamView.runsScoredLabel.text = text;
}

- (void)setAwayTeamLogoWithID:(NSString *)teamID {
    _awayTeamView.teamLogoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", teamID]];
}

- (void)setHomeTeamLogoWithID:(NSString *)teamID {
    _homeTeamView.teamLogoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", teamID]];
}

- (void)setLinescoreWithAwayScore:(NSString *)awayScore andHomeScore:(NSString *)homeScore
                      andAwayHits:(NSString *)awayHits andHomeHits:(NSString *)homeHits
                    andAwayErrors:(NSString *)awayErrors andHomeErrors:(NSString *)homeErrors
                 andAwayTeamLabel:(NSString *)awayLabel andHomeTeamLabel:(NSString *)homeLabel {
    _linescoreView.awayScoreLabel.text = awayScore;
    _linescoreView.awayHitsLabel.text = awayHits;
    _linescoreView.awayErrorsLabel.text = awayErrors;
    _linescoreView.awayTeamLabel.text = awayLabel;
    _linescoreView.homeScoreLabel.text = homeScore;
    _linescoreView.homeHitsLabel.text = homeHits;
    _linescoreView.homeErrorsLabel.text = homeErrors;
    _linescoreView.homeTeamLabel.text = homeLabel;
}

- (void)setLinescoreWithInnings:(NSMutableArray *)innings {
    for(int x = 0; x < [innings count]; x++) {
        STCInning *inn = [innings objectAtIndex:x];
        STCLinescoreInningLabel *innLabel = [[_linescoreView titleInningLabels] objectAtIndex:x];
        innLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [innLabel setText:[NSString stringWithFormat:@"%@", inn.number]];
        
        [[[_linescoreView awayInningLabels] objectAtIndex:x]
         setText:(inn.awayTeamScore ? [NSString stringWithFormat:@"%@", inn.awayTeamScore] : @"x")];
        
        [[[_linescoreView homeInningLabels] objectAtIndex:x]
         setText:(inn.homeTeamScore ? [NSString stringWithFormat:@"%@", inn.homeTeamScore] : @"x")];
    }
}

- (void)setWinningPitcherText:(NSString *)text {
    _winningPitcherLabel.text = text;
}

- (void)setLosingPitcherText:(NSString *)text {
    _losingPitcherLabel.text = text;
}

- (void)setSavingPitcherText:(NSString *)text {
    _savingPitcherLabel.text = text;
}

@end
