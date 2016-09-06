//
//  STGamePreviewViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewViewController.h"
#import "STCPreviewParser.h"
#import "STCPreviewTeamView.h"

@implementation STCPreviewViewController {
    STCPreviewParser *_previewParser;
    STCPreviewTeamView *_awayPreviewTeamView;
    STCPreviewTeamView *_homePreviewTeamView;
    NSString *_gameID;
    UILabel *_versusLabel;
}

- (instancetype)initWithGameID:(NSString*)gameID {
    self = [super init];
    if (self) {
        _gameID = gameID;
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"Game Preview";
    }
    return self;
}

- (void)parsedGamePreview:(STCPreview *)preview {
    // away team logo and info
    [_awayPreviewTeamView.teamLogoView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[preview awayTeamID]]]];
    [_awayPreviewTeamView.teamInfoLabel setText:[STCGlobals getFullNameForTeamID:[preview awayTeamID]]];
    
    // away pitcher name and ERA
    NSString *awayFullName = [NSString stringWithFormat:@"%@ %@", preview.awayProbablePitcher.firstName, preview.awayProbablePitcher.lastName];
    [_awayPreviewTeamView.pitcherNameLabel setText:awayFullName];
    [_awayPreviewTeamView.pitcherERALabel setText:[NSString stringWithFormat:@"%@ ERA", preview.awayProbablePitcher.era]];
    
    // away pitcher win-loss
    NSString *awayPitcherRecord = [NSString stringWithFormat:@"%@-%@", preview.awayProbablePitcher.wins, preview.awayProbablePitcher.losses];
    [_awayPreviewTeamView.pitcherRecordLabel setText:awayPitcherRecord];
    
    // away pitcher picture
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:
                          [NSURL URLWithString:
                           [NSString stringWithFormat:@"http://mlb.mlb.com/images/players/assets/74_%@.png", preview.awayProbablePitcher.playerID]]];
    _awayPreviewTeamView.pitcherImageView.image = [UIImage imageWithData: imageData];
    
    // home team logo and info
    [_homePreviewTeamView.teamLogoView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[preview homeTeamID]]]];
    [_homePreviewTeamView.teamInfoLabel setText:[STCGlobals getFullNameForTeamID:[preview homeTeamID]]];
    
    // home team pitcher name and ERA
    NSString *homeFullName = [NSString stringWithFormat:@"%@ %@", preview.homeProbablePitcher.firstName, preview.homeProbablePitcher.lastName];
    [_homePreviewTeamView.pitcherNameLabel setText:homeFullName];
    [_homePreviewTeamView.pitcherERALabel setText:[NSString stringWithFormat:@"%@ ERA", preview.homeProbablePitcher.era]];
    
    // home pitcher win-loss
    NSString *homePitcherRecord = [NSString stringWithFormat:@"%@-%@", preview.homeProbablePitcher.wins, preview.homeProbablePitcher.losses];
    [_homePreviewTeamView.pitcherRecordLabel setText:homePitcherRecord];
    
    // home pitcher picture
    imageData = [[NSData alloc] initWithContentsOfURL:
                          [NSURL URLWithString:
                           [NSString stringWithFormat:@"http://mlb.mlb.com/images/players/assets/68_%@.png", preview.homeProbablePitcher.playerID]]];
    _homePreviewTeamView.pitcherImageView.image = [UIImage imageWithData: imageData];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _versusLabel = [[UILabel alloc] init];
    _versusLabel.text = @"vs.";
    _versusLabel.font = [UIFont boldSystemFontOfSize:24.0f];
    _versusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_versusLabel];
    
    _previewParser = [[STCPreviewParser alloc] init];
    [_previewParser setDelegate:self];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // ignore navbar
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _awayPreviewTeamView = [[STCPreviewTeamView alloc] init];
    _awayPreviewTeamView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_awayPreviewTeamView];
    
    _homePreviewTeamView = [[STCPreviewTeamView alloc] init];
    _homePreviewTeamView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_homePreviewTeamView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_awayPreviewTeamView, _versusLabel, _homePreviewTeamView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_awayPreviewTeamView]-(>=1)-[_versusLabel]-(>=1)-[_homePreviewTeamView]-|"
                                                                      options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:nil
                                                                        views:views]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayPreviewTeamView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_homePreviewTeamView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:_versusLabel
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1
                              constant:0]];
    
    [_previewParser parsePreviewWithGameID:_gameID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
