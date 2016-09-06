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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ignore navbar
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // set up the UI elements
    _awayTeamView = [[STCFinalizedTeamView alloc] init];
    _awayTeamView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:_awayTeamView];
    
    _homeTeamView = [[STCFinalizedTeamView alloc] init];
    _homeTeamView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:_homeTeamView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_awayTeamView, _homeTeamView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayTeamView]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_homeTeamView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    // set up the parser
    _parser = [[STCFinalizedParser alloc] init];
    _parser.delegate = self;
    [_parser parseFinalizedGameWithID:_gameID];
}

@end
