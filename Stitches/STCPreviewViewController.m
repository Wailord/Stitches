//
//  STGamePreviewViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewViewController.h"
#import "STCPreviewParser.h"
#import "STCPreviewView.h"

@implementation STCPreviewViewController {
    STCPreviewParser *_previewParser;
    STCPreviewView *_awayPreviewView;
    STCPreviewView *_homePreviewView;
    NSString *_gameID;
}

- (instancetype)initWithGameID:(NSString*)gameID {
    self = [super init];
    if (self) {
        _gameID = gameID;
        self.navigationItem.title = @"Game Preview";
    }
    return self;
}

- (void)parsedGamePreview:(STCPreview *)preview {
    [_awayPreviewView.teamLogoView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[preview awayTeamID]]]];
    [_awayPreviewView.teamInfoLabel setText:[[[STCGlobals teamDict] objectForKey:[preview awayTeamID]] fullName]];
    
    NSString *awayFullName = [NSString stringWithFormat:@"%@ %@", preview.awayProbablePitcher.firstName, preview.awayProbablePitcher.lastName];
    [_awayPreviewView.pitcherNameLabel setText:awayFullName];
      
    [_homePreviewView.teamLogoView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[preview homeTeamID]]]];
    [_homePreviewView.teamInfoLabel setText:[[[STCGlobals teamDict] objectForKey:[preview homeTeamID]] fullName]];
    
    NSString *homeFullName = [NSString stringWithFormat:@"%@ %@", preview.homeProbablePitcher.firstName, preview.homeProbablePitcher.lastName];
    [_homePreviewView.pitcherNameLabel setText:homeFullName];
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _awayPreviewView = [[STCPreviewView alloc] init];
    _awayPreviewView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.view addSubview:_awayPreviewView];
    
    _homePreviewView = [[STCPreviewView alloc] init];
    _homePreviewView.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.view addSubview:_homePreviewView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_awayPreviewView, _homePreviewView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_awayPreviewView]-10-[_homePreviewView]-|"
                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                 metrics:nil
                                                                   views:views]];
    
    [_previewParser parsePreviewWithGameID:_gameID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
