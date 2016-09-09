//
//  STCFinalViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedViewController.h"

@interface STCFinalizedViewController ()<STCFinalizedParserDelegate> {
    NSString *_gameID;
    STCFinalizedParser *_parser;
    STCFinalizedView *_view;
    UIScrollView *_contentScrollView;
}

@end

@implementation STCFinalizedViewController

- (instancetype)initWithGameID:(NSString*)gameID {
    self = [super init];
    if (self) {
        _gameID = gameID;
        
        // add a scrollview
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _view = [[STCFinalizedView alloc] init];
        _view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_contentScrollView addSubview:_view];
        [self.view addSubview:_contentScrollView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_contentScrollView);
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentScrollView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentScrollView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)parsedFinalizedGame:(STCFinalizedGame *)final {
    //NSLog(@"Parsed finalized game: %@", final);
    // team names/records
    NSString *awayBrief = [STCGlobals getBriefNameForTeamID:final.awayTeam.teamID];
    NSString *homeBrief = [STCGlobals getBriefNameForTeamID:final.homeTeam.teamID];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ @ %@", awayBrief, homeBrief];
    
    [_view setAwayTeamNameText:awayBrief];
    [_view setHomeTeamNameText:homeBrief];
    
    [_view setAwayTeamInfoText:[NSString stringWithFormat:@"%@", final.awayTeam.teamRecord]];
    [_view setHomeTeamInfoText:[NSString stringWithFormat:@"%@", final.homeTeam.teamRecord]];
    
    // runs scored
    [_view setAwayRunsScoredText:[NSString stringWithFormat:@"%@", final.awayTeam.runsScored]];
    [_view setHomeRunsScoredText:[NSString stringWithFormat:@"%@", final.homeTeam.runsScored]];
    
    // linescore
    [_view setLinescoreWithAwayScore:[NSString stringWithFormat:@"%@", final.awayTeam.runsScored]
                        andHomeScore:[NSString stringWithFormat:@"%@", final.homeTeam.runsScored]
                         andAwayHits:[NSString stringWithFormat:@"%@", final.awayTeam.hits]
                         andHomeHits:[NSString stringWithFormat:@"%@", final.homeTeam.hits]
                       andAwayErrors:[NSString stringWithFormat:@"%@", final.awayTeam.errors]
                       andHomeErrors:[NSString stringWithFormat:@"%@", final.homeTeam.errors]
                    andAwayTeamLabel:[NSString stringWithFormat:@"%@", [STCGlobals getAbbreviationForTeamID:final.awayTeam.teamID]]
                    andHomeTeamLabel:[NSString stringWithFormat:@"%@", [STCGlobals getAbbreviationForTeamID:final.homeTeam.teamID]]];
    // team logo
    [_view setAwayTeamLogoWithID:final.awayTeam.teamID];
    [_view setHomeTeamLogoWithID:final.homeTeam.teamID];
    
    [_view setLinescoreWithInnings:final.innings];
    
    // winning/losing/saving pitchers
    [_view setWinningPitcherText:[NSString stringWithFormat:@"WP: %@", final.winningPitcher]];
    [_view setLosingPitcherText:[NSString stringWithFormat:@"LP: %@", final.losingPitcher]];
    
    if(final.savingPitcher) {
        [_view setSavingPitcherText:[NSString stringWithFormat:@"SV: %@", final.savingPitcher]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLayoutConstraint *equalWidth = [NSLayoutConstraint constraintWithItem:_view
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_contentScrollView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0
                                                                   constant:0];
    equalWidth.active = YES;
    
    NSLayoutConstraint *equalTop = [NSLayoutConstraint constraintWithItem:_view
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:_contentScrollView
                                              attribute:NSLayoutAttributeTop
                                             multiplier:1.0
                                               constant:0];
    equalTop.active = YES;
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_view
                                              attribute:NSLayoutAttributeCenterX
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:_contentScrollView
                                              attribute:NSLayoutAttributeCenterX
                                             multiplier:1.0
                                               constant:0];
    centerX.active = YES;
    
    _parser = [[STCFinalizedParser alloc] init];
    _parser.delegate = self;
    [_parser parseFinalizedGameWithID:_gameID];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _contentScrollView.contentSize = _view.bounds.size;
}

@end
