//
//  STCFinalViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedViewController.h"

@interface STCFinalizedViewController () {
    NSString *_gameID;
    STCFinalizedParser *_parser;
    STCFinalizedTeamView *_awayTeamView;
    STCFinalizedTeamView *_homeTeamView;
    STCLinescoreView *_linescoreView;
    
    UIScrollView *_contentScrollView;
    UIView *_container;
    
    UILabel *_winningPitcherLabel;
    UILabel *_losingPitcherLabel;
    UILabel *_savingPitcherLabel;
}

@end

@implementation STCFinalizedViewController

- (instancetype)initWithGameID:(NSString*)gameID {
    self = [super init];
    if (self) {
        _gameID = gameID;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)parsedFinalizedGame:(STCFinalizedGame *)final {
    //NSLog(@"Parsed finalized game: %@", final);
    // team names/records
    NSString *awayBrief =[STCGlobals getBriefNameForTeamID:final.awayTeam.teamID];
    NSString *homeBrief =[STCGlobals getBriefNameForTeamID:final.homeTeam.teamID];
    _awayTeamView.teamNameLabel.text = awayBrief;
    _homeTeamView.teamNameLabel.text = homeBrief;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ @ %@", awayBrief, homeBrief];
    
    _awayTeamView.teamInfoLabel.text = [final.awayTeam.teamRecord description];
    _homeTeamView.teamInfoLabel.text = [final.homeTeam.teamRecord description];
    
    // runs scored
    _awayTeamView.runsScoredLabel.text = [NSString stringWithFormat:@"%@", final.awayTeam.runsScored];
    _homeTeamView.runsScoredLabel.text = [NSString stringWithFormat:@"%@", final.homeTeam.runsScored];
    
    // linescore
    _linescoreView.awayScoreLabel.text = [NSString stringWithFormat:@"%@", final.awayTeam.runsScored];
    _linescoreView.homeScoreLabel.text = [NSString stringWithFormat:@"%@", final.homeTeam.runsScored];
    _linescoreView.awayHitsLabel.text = [NSString stringWithFormat:@"%@", final.awayTeam.hits];
    _linescoreView.homeHitsLabel.text = [NSString stringWithFormat:@"%@", final.homeTeam.hits];
    _linescoreView.awayErrorsLabel.text = [NSString stringWithFormat:@"%@", final.awayTeam.errors];
    _linescoreView.homeErrorsLabel.text = [NSString stringWithFormat:@"%@", final.homeTeam.errors];
    _linescoreView.awayTeamLabel.text = [NSString stringWithFormat:@"%@", [STCGlobals getAbbreviationForTeamID:final.awayTeam.teamID]];
    _linescoreView.homeTeamLabel.text = [NSString stringWithFormat:@"%@", [STCGlobals getAbbreviationForTeamID:final.homeTeam.teamID]];
    
    // team logo
    _awayTeamView.teamLogoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", final.awayTeam.teamID]];
    _homeTeamView.teamLogoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", final.homeTeam.teamID]];
    
    for(int x = 0; x < [final.innings count]; x++) {
        STCInning *inn = [final.innings objectAtIndex:x];
        STCLinescoreInningLabel *innLabel = [[_linescoreView titleInningLabels] objectAtIndex:x];
        innLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [innLabel setText:[NSString stringWithFormat:@"%@", inn.number]];
        
        [[[_linescoreView awayInningLabels] objectAtIndex:x]
         setText:(inn.awayTeamScore ? [NSString stringWithFormat:@"%@", inn.awayTeamScore] : @"x")];
        
        [[[_linescoreView homeInningLabels] objectAtIndex:x]
         setText:(inn.homeTeamScore ? [NSString stringWithFormat:@"%@", inn.homeTeamScore] : @"x")];
    }
    
    // winning/losing/saving pitchers
    _winningPitcherLabel.text = [NSString stringWithFormat:@"WP: %@", final.winningPitcher];
    _losingPitcherLabel.text = [NSString stringWithFormat:@"LP: %@", final.losingPitcher];
    
    if(final.savingPitcher) {
        _savingPitcherLabel.text = [NSString stringWithFormat:@"SV: %@", final.savingPitcher];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ignore navbar
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // add a scrollview
    _contentScrollView = [[UIScrollView alloc] init];
    _contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
    
    _container = [UIView new];
    _container.translatesAutoresizingMaskIntoConstraints = NO;
    
    _winningPitcherLabel = [[UILabel alloc] init];
    _winningPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _winningPitcherLabel.textAlignment = NSTextAlignmentCenter;
    [_container addSubview:_winningPitcherLabel];
    
    _losingPitcherLabel = [[UILabel alloc] init];
    _losingPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _losingPitcherLabel.textAlignment = NSTextAlignmentCenter;
    [_container addSubview:_losingPitcherLabel];
    
    _savingPitcherLabel = [[UILabel alloc] init];
    _savingPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _savingPitcherLabel.textAlignment = NSTextAlignmentCenter;
    [_container addSubview:_savingPitcherLabel];
    
    // set up the UI elements
    _awayTeamView = [[STCFinalizedTeamView alloc] init];
    _awayTeamView.translatesAutoresizingMaskIntoConstraints = NO;
    [_container addSubview:_awayTeamView];
    
    _homeTeamView = [[STCFinalizedTeamView alloc] init];
    _homeTeamView.translatesAutoresizingMaskIntoConstraints = NO;
    [_container addSubview:_homeTeamView];
    
    _linescoreView = [[STCLinescoreView alloc] init];
    _linescoreView.translatesAutoresizingMaskIntoConstraints = NO;
    [_container addSubview:_linescoreView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_contentScrollView, _awayTeamView, _homeTeamView,_linescoreView,
                                                         _winningPitcherLabel, _losingPitcherLabel, _savingPitcherLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentScrollView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentScrollView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [_container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayTeamView]-(>=20)-[_homeTeamView]-|"
                                                                      options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                      metrics:nil
                                                                        views:views]];
    
    [_container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_savingPitcherLabel]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [_container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_losingPitcherLabel]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [_container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_linescoreView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [_container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_winningPitcherLabel]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [_container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_awayTeamView]-[_winningPitcherLabel]-[_losingPitcherLabel]-[_savingPitcherLabel]-[_linescoreView]-(>=3)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [_contentScrollView addSubview:_container];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_container attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentScrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    constraint.active = YES;
    
    constraint = [NSLayoutConstraint constraintWithItem:_container attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentScrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    constraint.active = YES;
    
    // set up the parser
    _parser = [[STCFinalizedParser alloc] init];
    _parser.delegate = self;
    [_parser parseFinalizedGameWithID:_gameID];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _contentScrollView.contentSize = _contentScrollView.subviews[0].bounds.size;
}

@end
