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
#import "STCGlobals.h"

@implementation STCFinalizedView

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

- (void)setGame:(STCFinalizedGame*)game {
    [_homeTeamView setTeam:game.homeTeam];
    [_awayTeamView setTeam:game.awayTeam];
    
    _linescoreView.awayScoreLabel.text = game.awayTeam.runsScored.stringValue;
    _linescoreView.homeScoreLabel.text = game.homeTeam.runsScored.stringValue;
    _linescoreView.awayHitsLabel.text = game.awayTeam.hits.stringValue;
    _linescoreView.homeHitsLabel.text = game.homeTeam.hits.stringValue;
    _linescoreView.awayErrorsLabel.text = game.awayTeam.errors.stringValue;
    _linescoreView.homeErrorsLabel.text = game.homeTeam.errors.stringValue;
    _linescoreView.awayTeamLabel.text = [STCGlobals abbreviationForTeamID:game.awayTeam.teamID];
    _linescoreView.homeTeamLabel.text = [STCGlobals abbreviationForTeamID:game.homeTeam.teamID];
    
    [self setLinescoreWithInnings:game.innings];
    
    // winning/losing/saving pitchers
    _winningPitcherLabel.text = [NSString stringWithFormat:@"WP: %@", game.winningPitcher];
    _losingPitcherLabel.text = [NSString stringWithFormat:@"LP: %@", game.losingPitcher];
    
    if(game.savingPitcher) {
        _savingPitcherLabel.text = [NSString stringWithFormat:@"SV: %@", game.savingPitcher];
    }

}

- (void)setLinescoreWithInnings:(NSMutableArray *)innings {
    for(int x = 0; x < innings.count; x++) {
        STCInning *inn = innings[x];
        UILabel *innLabel = _linescoreView.titleInningLabels[x];
        innLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        innLabel.text = [NSString stringWithFormat:@"%@", inn.number];
        
        [_linescoreView.awayInningLabels[x]
         setText:(inn.awayTeamScore ? [NSString stringWithFormat:@"%@", inn.awayTeamScore] : @"x")];
        
        [_linescoreView.homeInningLabels[x]
         setText:(inn.homeTeamScore ? [NSString stringWithFormat:@"%@", inn.homeTeamScore] : @"x")];
    }
}

@end
