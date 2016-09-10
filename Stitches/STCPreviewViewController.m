//
//  STGamePreviewViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewViewController.h"
#import "STCPreviewTeamView.h"
#import "STCPreviewView.h"
#import "STCPreviewParser.h"
#import "STCGlobals.h"

@interface STCPreviewViewController ()<STCPreviewParserDelegate> {
    STCPreviewParser *_previewParser;
    NSString *_gameID;
    STCPreviewView *_previewView;
    UIScrollView *_contentScrollView;
}

@end

@implementation STCPreviewViewController

- (instancetype)initWithGameID:(NSString*)gameID {
    self = [super init];
    if (self) {
        _gameID = gameID;
        
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        //_previewView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baseball.png"]];
        
        _previewView = [[STCPreviewView alloc] init];
        _previewView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_contentScrollView addSubview:_previewView];
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
        self.navigationItem.title = @"Game Preview";
    }
    
    return self;
}

- (void)parsedGamePreview:(STCPreview *)preview {
    [_previewView setVenueText:[[preview venue] name]];
    [_previewView setLocationText:[[preview venue] location]];
    [_previewView setStartTimeTextWithDate:[preview startTime]];
     
    // away team view setup
    [_previewView setTeamLogoForID:[[preview awayTeam] teamID] forTeamType:STCAwayTeam];
    [_previewView setTeamNameText:[STCGlobals getFullNameForTeamID:[[preview awayTeam] teamID]]
                      forTeamType:STCAwayTeam];
    [_previewView setTeamRecordText:[NSString stringWithFormat:@"(%@)", preview.awayTeam.teamRecord]
                        forTeamType:STCAwayTeam];
    
    NSString *awayFullName = [NSString stringWithFormat:@"%@ %@",
                              [[[preview awayTeam] probablePitcher] firstName],
                              [[[preview awayTeam] probablePitcher] lastName]];
    [_previewView setProbablePitcherNameText:awayFullName
                             forTeamType:STCAwayTeam];
    [_previewView setProbablePitcherERAText:[NSString stringWithFormat:@"%@ ERA",
                                             [[[preview awayTeam] probablePitcher] era]]
                                forTeamType:STCAwayTeam];
    
    NSString *awayPitcherRecord = [NSString stringWithFormat:@"%@-%@",
                                   [[[preview awayTeam] probablePitcher] wins],
                                   [[[preview awayTeam] probablePitcher] losses]];
    [_previewView setProbablePitcherRecordText:awayPitcherRecord
                                   forTeamType:STCAwayTeam];
    
    [_previewView setProbablePitcherImageForID:[[[preview awayTeam] probablePitcher] playerID]
                                   forTeamType:STCAwayTeam];
    
    
    // home team view setup
    [_previewView setTeamLogoForID:[[preview homeTeam] teamID]
                       forTeamType:STCHomeTeam];
    [_previewView setTeamNameText:[STCGlobals getFullNameForTeamID:[[preview homeTeam] teamID]]
                      forTeamType:STCHomeTeam];
    [_previewView setTeamRecordText:[NSString stringWithFormat:@"(%@)", preview.homeTeam.teamRecord]
                        forTeamType:STCHomeTeam];
    
    NSString *homeFullName = [NSString stringWithFormat:@"%@ %@",
                              [[[preview homeTeam] probablePitcher] firstName],
                              [[[preview homeTeam] probablePitcher] lastName]];
    [_previewView setProbablePitcherNameText:homeFullName
                             forTeamType:STCHomeTeam];
    [_previewView setProbablePitcherERAText:[NSString stringWithFormat:@"%@ ERA",
                                             [[[preview homeTeam] probablePitcher] era]]
                                forTeamType:STCHomeTeam];
    
    NSString *homePitcherRecord = [NSString stringWithFormat:@"%@-%@",
                                   [[[preview homeTeam] probablePitcher] wins],
                                   [[[preview homeTeam] probablePitcher] losses]];
    [_previewView setProbablePitcherRecordText:homePitcherRecord
                                   forTeamType:STCHomeTeam];
    
    [_previewView setProbablePitcherImageForID:[[[preview homeTeam] probablePitcher] playerID]
                                   forTeamType:STCHomeTeam];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ignore navbar
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    NSLayoutConstraint *equalWidth = [NSLayoutConstraint constraintWithItem:_previewView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_contentScrollView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0
                                                                   constant:0];
    equalWidth.active = YES;
    
    NSLayoutConstraint *equalTop = [NSLayoutConstraint constraintWithItem:_previewView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentScrollView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:0];
        equalTop.active = YES;
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_previewView
                                                                attribute:NSLayoutAttributeCenterX
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentScrollView
                                                                attribute:NSLayoutAttributeCenterX
                                                               multiplier:1.0
                                                                 constant:0];
    centerX.active = YES;
    

    
    _previewParser = [[STCPreviewParser alloc] init];
    [_previewParser setDelegate:self];
    
    [_previewParser parsePreviewWithGameID:_gameID];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _contentScrollView.contentSize = _previewView.bounds.size;

}

@end
