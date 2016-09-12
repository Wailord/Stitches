//
//  STCFinalViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedViewController.h"
#import "STCFinalizedParser.h"
#import "STCLinescoreView.h"
#import "STCFinalizedTeamView.h"
#import "STCFinalizedView.h"
#import "STCGlobals.h"

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
        _contentScrollView = [UIScrollView new];
        _contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _view = [STCFinalizedView new];
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
    [_view setGame:final];
    NSString *awayBrief = [STCGlobals briefNameForTeamID:final.awayTeam.teamID];
    NSString *homeBrief = [STCGlobals briefNameForTeamID:final.homeTeam.teamID];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ @ %@", awayBrief, homeBrief];
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
    
    _parser = [STCFinalizedParser new];
    _parser.delegate = self;
    [_parser parseFinalizedGameWithID:_gameID];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _contentScrollView.contentSize = _view.bounds.size;
}

@end
