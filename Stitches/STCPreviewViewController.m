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
    STCPreviewTeamView *_awayPreviewView;
    STCPreviewTeamView *_homePreviewView;
    NSString *_gameID;
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
    [_awayPreviewView.teamLogoView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[preview awayTeamID]]]];
    [_awayPreviewView.teamInfoLabel setText:[STCGlobals getFullNameForTeamID:[preview awayTeamID]]];
    
    // away pitcher name and ERA
    NSString *awayFullName = [NSString stringWithFormat:@"%@ %@", preview.awayProbablePitcher.firstName, preview.awayProbablePitcher.lastName];
    [_awayPreviewView.pitcherNameLabel setText:awayFullName];
    [_awayPreviewView.pitcherERALabel setText:preview.awayProbablePitcher.era];
    
    // away pitcher win-loss
    NSString *awayPitcherRecord = [NSString stringWithFormat:@"%@-%@", preview.awayProbablePitcher.wins, preview.awayProbablePitcher.losses];
    [_awayPreviewView.pitcherRecordLabel setText:awayPitcherRecord];
    
    // away pitcher picture
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:
                          [NSURL URLWithString:
                           [NSString stringWithFormat:@"http://mlb.mlb.com/images/players/assets/68_%@.png", preview.awayProbablePitcher.playerID]]];
    _awayPreviewView.pitcherImageView.image = [UIImage imageWithData: imageData];
    
    // home team logo and info
    [_homePreviewView.teamLogoView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[preview homeTeamID]]]];
    [_homePreviewView.teamInfoLabel setText:[STCGlobals getFullNameForTeamID:[preview homeTeamID]]];
    
    // home team pitcher name and ERA
    NSString *homeFullName = [NSString stringWithFormat:@"%@ %@", preview.homeProbablePitcher.firstName, preview.homeProbablePitcher.lastName];
    [_homePreviewView.pitcherNameLabel setText:homeFullName];
    [_homePreviewView.pitcherERALabel setText:preview.homeProbablePitcher.era];
    
    // home pitcher win-loss
    NSString *homePitcherRecord = [NSString stringWithFormat:@"%@-%@", preview.homeProbablePitcher.wins, preview.homeProbablePitcher.losses];
    [_homePreviewView.pitcherRecordLabel setText:homePitcherRecord];
    
    // home pitcher picture
    imageData = [[NSData alloc] initWithContentsOfURL:
                          [NSURL URLWithString:
                           [NSString stringWithFormat:@"http://mlb.mlb.com/images/players/assets/68_%@.png", preview.homeProbablePitcher.playerID]]];
    _homePreviewView.pitcherImageView.image = [UIImage imageWithData: imageData];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _previewParser = [[STCPreviewParser alloc] init];
    [_previewParser setDelegate:self];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
    
    // ignore navbar
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _awayPreviewView = [[STCPreviewTeamView alloc] init];
    _awayPreviewView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.view addSubview:_awayPreviewView];
    
    _homePreviewView = [[STCPreviewTeamView alloc] init];
    _homePreviewView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.view addSubview:_homePreviewView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_awayPreviewView, _homePreviewView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_awayPreviewView]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_homePreviewView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayPreviewView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_homePreviewView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [_previewParser parsePreviewWithGameID:_gameID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
