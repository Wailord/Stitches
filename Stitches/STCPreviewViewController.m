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
        
        _contentScrollView = [UIScrollView new];
        _contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        //_previewView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baseball.png"]];
        
        _previewView = [STCPreviewView new];
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
    _previewView.venueLabel.text = preview.venue.name;
    _previewView.locationLabel.text = preview.venue.location;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"h:mm a";
    _previewView.startTimeLabel.text = [formatter stringFromDate:preview.startTime];
    
    [_previewView.awayPreviewTeamView setTeam:preview.awayTeam];
    [_previewView.homePreviewTeamView setTeam:preview.homeTeam];
    
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
    

    
    _previewParser = [STCPreviewParser new];
    _previewParser.delegate = self;
    
    [_previewParser parsePreviewWithGameID:_gameID];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _contentScrollView.contentSize = _previewView.bounds.size;

}

@end
