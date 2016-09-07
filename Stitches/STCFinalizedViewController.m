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
        self.navigationItem.title = @"Final";
    }
    return self;
}

- (void)parsedFinalizedGame:(STCFinalizedGame *)final {
    NSLog(@"Parsed finalized game: %@", final);
    _awayTeamView.teamRecordLabel.text = [STCGlobals getBriefNameForTeamID:final.awayTeam.teamID];
    _homeTeamView.teamRecordLabel.text = [STCGlobals getBriefNameForTeamID:final.homeTeam.teamID];
    _awayTeamView.runsScoredLabel.text = [NSString stringWithFormat:@"%@", final.awayTeam.runsScored];
    _homeTeamView.runsScoredLabel.text = [NSString stringWithFormat:@"%@", final.homeTeam.runsScored];
    _linescoreView.awayScoreLabel.text = [NSString stringWithFormat:@"%@", final.awayTeam.runsScored];
    _linescoreView.homeScoreLabel.text = [NSString stringWithFormat:@"%@", final.homeTeam.runsScored];
    _linescoreView.awayHitsLabel.text = [NSString stringWithFormat:@"%@", final.awayTeam.hits];
    _linescoreView.homeHitsLabel.text = [NSString stringWithFormat:@"%@", final.homeTeam.hits];
    _linescoreView.awayErrorsLabel.text = [NSString stringWithFormat:@"%@", final.awayTeam.errors];
    _linescoreView.homeErrorsLabel.text = [NSString stringWithFormat:@"%@", final.homeTeam.errors];
    _linescoreView.awayTeamLabel.text = [NSString stringWithFormat:@"%@", [STCGlobals getAbbreviationForTeamID:final.awayTeam.teamID]];
    _linescoreView.homeTeamLabel.text = [NSString stringWithFormat:@"%@", [STCGlobals getAbbreviationForTeamID:final.homeTeam.teamID]];
    
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
    
    _winningPitcherLabel = [[UILabel alloc] init];
    _winningPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_winningPitcherLabel];
    _losingPitcherLabel = [[UILabel alloc] init];
    _losingPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_losingPitcherLabel];
    _savingPitcherLabel = [[UILabel alloc] init];
    _savingPitcherLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_savingPitcherLabel];
    
    // set up the UI elements
    _awayTeamView = [[STCFinalizedTeamView alloc] init];
    _awayTeamView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_awayTeamView];
    
    _homeTeamView = [[STCFinalizedTeamView alloc] init];
    _homeTeamView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_homeTeamView];
    
    _linescoreView = [[STCLinescoreView alloc] init];
    _linescoreView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_linescoreView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_awayTeamView, _homeTeamView,_linescoreView,
                                                         _winningPitcherLabel, _losingPitcherLabel, _savingPitcherLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayTeamView]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_homeTeamView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_awayTeamView]-50-[_winningPitcherLabel]-15-[_losingPitcherLabel]-15-[_savingPitcherLabel]-15-[_linescoreView]"
                                                                      options:NSLayoutFormatAlignAllLeft
                                                                      metrics:nil
                                                                        views:views]];
    
    // set up the parser
    _parser = [[STCFinalizedParser alloc] init];
    _parser.delegate = self;
    [_parser parseFinalizedGameWithID:_gameID];
}

@end
