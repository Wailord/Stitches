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
        
        _winningPitcherLabel = [UILabel new];
        _winningPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _winningPitcherLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_winningPitcherLabel];
        
        _losingPitcherLabel = [UILabel new];
        _losingPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _losingPitcherLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_losingPitcherLabel];
        
        _savingPitcherLabel = [UILabel new];
        _savingPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _savingPitcherLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_savingPitcherLabel];
        
        // set up the UI elements
        _awayTeamView = [STCFinalizedTeamView new];
        _awayTeamView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_awayTeamView];
        
        _homeTeamView = [STCFinalizedTeamView new];
        _homeTeamView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_homeTeamView];
        
        _linescoreView = [STCLinescoreView new];
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
    [_awayTeamView setTeamNameText:text];
}

- (void)setHomeTeamNameText:(NSString *)text {
    [_homeTeamView setTeamNameText:text];
}

- (void)setAwayTeamInfoText:(NSString *)text {
    [_awayTeamView setTeamInfoText:text];
}

- (void)setHomeTeamInfoText:(NSString *)text {
    [_homeTeamView setTeamInfoText:text];
}

- (void)setAwayRunsScoredText:(NSString *)text; {
    [_awayTeamView setRunsScoredText:text];
}

- (void)setHomeRunsScoredText:(NSString *)text {
    [_homeTeamView setRunsScoredText:text];
}

- (void)setAwayTeamLogoWithID:(NSString *)teamID {
    [_awayTeamView setTeamLogoWithID:teamID];
}

- (void)setHomeTeamLogoWithID:(NSString *)teamID {
    [_homeTeamView setTeamLogoWithID:teamID];
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
    for(int x = 0; x < innings.count; x++) {
        STCInning *inn = innings[x];
        STCLinescoreInningLabel *innLabel = _linescoreView.titleInningLabels[x];
        innLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        innLabel.text = [NSString stringWithFormat:@"%@", inn.number];
        
        [_linescoreView.awayInningLabels[x]
         setText:(inn.awayTeamScore ? [NSString stringWithFormat:@"%@", inn.awayTeamScore] : @"x")];
        
        [_linescoreView.homeInningLabels[x]
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
