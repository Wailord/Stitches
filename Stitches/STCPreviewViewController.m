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
    NSLog(@"PreviewViewController responding to parsed game. Setting up view.");
    // away team logo and info
    [_awayPreviewTeamView.teamLogoView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[preview awayTeam] teamID]]]];
    [_awayPreviewTeamView.teamNameLabel setText:[STCGlobals getFullNameForTeamID:[[preview awayTeam] teamID]]];
    _awayPreviewTeamView.teamRecordLabel.text = [NSString stringWithFormat:@"(%@)", preview.awayTeam.teamRecord];
    
    // away pitcher name and ERA
    NSString *awayFullName = [NSString stringWithFormat:@"%@ %@",
                              [[[preview awayTeam] probablePitcher] firstName],
                              [[[preview awayTeam] probablePitcher] lastName]];
    [_awayPreviewTeamView.pitcherNameLabel setText:awayFullName];
    [_awayPreviewTeamView.pitcherERALabel setText:[NSString stringWithFormat:@"%@ ERA",
                                                   [[[preview awayTeam] probablePitcher] era]]];
    
    // away pitcher win-loss
    NSString *awayPitcherRecord = [NSString stringWithFormat:@"%@-%@",
                                   [[[preview awayTeam] probablePitcher] wins],
                                   [[[preview awayTeam] probablePitcher] losses]];
    [_awayPreviewTeamView.pitcherRecordLabel setText:awayPitcherRecord];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    // away pitcher picture
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:
                          [NSURL URLWithString:
                           [NSString stringWithFormat:@"http://mlb.mlb.com/images/players/assets/74_%@.png", [[[preview awayTeam] probablePitcher] playerID]]]];
    _awayPreviewTeamView.pitcherImageView.image = [UIImage imageWithData: imageData];
    });
    
    // home team logo and info
    [_homePreviewTeamView.teamLogoView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[preview homeTeam] teamID]]]];
    [_homePreviewTeamView.teamNameLabel setText:[STCGlobals getFullNameForTeamID:[[preview homeTeam] teamID]]];
    _homePreviewTeamView.teamRecordLabel.text = [NSString stringWithFormat:@"(%@)", preview.homeTeam.teamRecord];
    
    // home team pitcher name and ERA
    NSString *homeFullName = [NSString stringWithFormat:@"%@ %@",
                              [[[preview homeTeam] probablePitcher] firstName],
                              [[[preview homeTeam] probablePitcher] lastName]];
    [_homePreviewTeamView.pitcherNameLabel setText:homeFullName];
    [_homePreviewTeamView.pitcherERALabel setText:[NSString stringWithFormat:@"%@ ERA",
                                                   [[[preview homeTeam] probablePitcher] era]]];
    
    // home pitcher win-loss
    NSString *homePitcherRecord = [NSString stringWithFormat:@"%@-%@",
                                   [[[preview homeTeam] probablePitcher] wins],
                                   [[[preview homeTeam] probablePitcher] losses]];
    [_homePreviewTeamView.pitcherRecordLabel setText:homePitcherRecord];
    
    // home pitcher picture
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // away pitcher picture
        NSData * imageData = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:
                               [NSString stringWithFormat:@"http://mlb.mlb.com/images/players/assets/74_%@.png", [[[preview homeTeam] probablePitcher] playerID]]]];
        _homePreviewTeamView.pitcherImageView.image = [UIImage imageWithData: imageData];
    });
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"PreviewViewController finished responding to parsed game. Done setting up view.");
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
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_awayPreviewTeamView]-[_versusLabel]-[_homePreviewTeamView]-(>=1)-|"
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
    
    [_previewParser parsePreviewWithGameID:_gameID];
}

@end
