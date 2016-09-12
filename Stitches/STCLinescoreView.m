//
//  STCLinescoreView.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCLinescoreView.h"

@implementation STCLinescoreView {
    UILabel *_hitsLabel;
    UILabel *_scoreLabel;
    UILabel *_errorsLabel;
    UILabel *_dummyTeamLabel;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        UILabel *labelToAdd;
        NSMutableDictionary *views = [NSMutableDictionary new];
        
        // create the arrays of views
        _titleInningLabels = [[NSMutableArray<UILabel*> alloc] initWithCapacity:9];
        _awayInningLabels = [[NSMutableArray<UILabel*> alloc] initWithCapacity:9];
        _homeInningLabels = [[NSMutableArray<UILabel*> alloc] initWithCapacity:9];
        
        // create the team labels and the blank dummy label above
        _dummyTeamLabel = [UILabel new];
        _dummyTeamLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dummyTeamLabel.textAlignment = NSTextAlignmentCenter;
        _dummyTeamLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _dummyTeamLabel.layer.borderWidth = 1.0f;
        _dummyTeamLabel.font = [UIFont boldSystemFontOfSize:17];
        views[@"_dummyTeamLabel"] = _dummyTeamLabel;
        [self addSubview:_dummyTeamLabel];
        
        _awayTeamLabel = [UILabel new];
        _awayTeamLabel.font = [UIFont boldSystemFontOfSize:17];
        _awayTeamLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _awayTeamLabel.textAlignment = NSTextAlignmentCenter;
        _awayTeamLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _awayTeamLabel.layer.borderWidth = 1.0f;
        views[@"_awayTeamLabel"] = _awayTeamLabel;
        [self addSubview:_awayTeamLabel];
        
        _homeTeamLabel = [UILabel new];
        _homeTeamLabel.font = [UIFont boldSystemFontOfSize:17];
        _homeTeamLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _homeTeamLabel.textAlignment = NSTextAlignmentCenter;
        _homeTeamLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _homeTeamLabel.layer.borderWidth = 1.0f;
        views[@"_homeTeamLabel"] = _homeTeamLabel;
        [self addSubview:_homeTeamLabel];
        
        // create the constant RHE labels
        _scoreLabel = [UILabel new];
        _scoreLabel.text = @"R";
        _scoreLabel.font = [UIFont boldSystemFontOfSize:17];
        views[@"_scoreLabel"] = _scoreLabel;
        _scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _scoreLabel.layer.borderWidth = 1.0f;
        [self addSubview:_scoreLabel];
        
        _hitsLabel = [UILabel new];
        _hitsLabel.text = @"H";
        _hitsLabel.font = [UIFont boldSystemFontOfSize:17];
        _hitsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _hitsLabel.textAlignment = NSTextAlignmentCenter;
        _hitsLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _hitsLabel.layer.borderWidth = 1.0f;
        views[@"_hitsLabel"] = _hitsLabel;
        [self addSubview:_hitsLabel];

        _errorsLabel = [UILabel new];
        _errorsLabel.text = @"E";
        _errorsLabel.font = [UIFont boldSystemFontOfSize:17];
        _errorsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _errorsLabel.textAlignment = NSTextAlignmentCenter;
        _errorsLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _errorsLabel.layer.borderWidth = 1.0f;
        views[@"_errorsLabel"] = _errorsLabel;
        [self addSubview:_errorsLabel];

        // create the variable RHE labels
        _awayHitsLabel = [UILabel new];
        views[@"_awayHitsLabel"] = _awayHitsLabel;
        _awayHitsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _awayHitsLabel.textAlignment = NSTextAlignmentCenter;
        _awayHitsLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _awayHitsLabel.layer.borderWidth = 1.0f;
        [self addSubview:_awayHitsLabel];
        
        _awayScoreLabel = [UILabel new];
        _awayScoreLabel.font = [UIFont boldSystemFontOfSize:17];
        _awayScoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _awayScoreLabel.textAlignment = NSTextAlignmentCenter;
        _awayScoreLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _awayScoreLabel.layer.borderWidth = 1.0f;
        views[@"_awayScoreLabel"] = _awayScoreLabel;
        [self addSubview:_awayScoreLabel];
        
        _awayErrorsLabel = [UILabel new];
        views[@"_awayErrorsLabel"] = _awayErrorsLabel;
        _awayErrorsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _awayErrorsLabel.textAlignment = NSTextAlignmentCenter;
        _awayErrorsLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _awayErrorsLabel.layer.borderWidth = 1.0f;
        [self addSubview:_awayErrorsLabel];
        
        _homeHitsLabel = [UILabel new];
        views[@"_homeHitsLabel"] = _homeHitsLabel;
        _homeHitsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _homeHitsLabel.textAlignment = NSTextAlignmentCenter;
        _homeHitsLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _homeHitsLabel.layer.borderWidth = 1.0f;
        [self addSubview:_homeHitsLabel];
        
        _homeScoreLabel = [UILabel new];
        _homeScoreLabel.font = [UIFont boldSystemFontOfSize:17];
        _homeScoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _homeScoreLabel.textAlignment = NSTextAlignmentCenter;
        _homeScoreLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _homeScoreLabel.layer.borderWidth = 1.0f;
        views[@"_homeScoreLabel"] = _homeScoreLabel;
        [self addSubview:_homeScoreLabel];
        
        _homeErrorsLabel = [UILabel new];
        views[@"_homeErrorsLabel"] = _homeErrorsLabel;
        _homeErrorsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _homeErrorsLabel.textAlignment = NSTextAlignmentCenter;
        _homeErrorsLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _homeErrorsLabel.layer.borderWidth = 1.0f;
        [self addSubview:_homeErrorsLabel];
        
        // build nine of the inning views
        for(int x = 0; x < 9; x++) {
            labelToAdd = [UILabel new];
            _titleInningLabels[x] = labelToAdd;
            labelToAdd.translatesAutoresizingMaskIntoConstraints = NO;
            labelToAdd.textAlignment = NSTextAlignmentCenter;
            labelToAdd.layer.borderColor = [UIColor blackColor].CGColor;
            labelToAdd.layer.borderWidth = 1.0f;
            views[[NSString stringWithFormat:@"titleView%i",x]] = labelToAdd;
            [self addSubview:labelToAdd];
            
            labelToAdd = [UILabel new];
            labelToAdd.translatesAutoresizingMaskIntoConstraints = NO;
            labelToAdd.textAlignment = NSTextAlignmentCenter;
            labelToAdd.layer.borderColor = [UIColor blackColor].CGColor;
            labelToAdd.layer.borderWidth = 1.0f;
            [_awayInningLabels setObject:labelToAdd atIndexedSubscript:x];
            views[[NSString stringWithFormat:@"awayInningView%i",x]] = labelToAdd;
            [self addSubview:labelToAdd];
            
            labelToAdd = [UILabel new];
            labelToAdd.translatesAutoresizingMaskIntoConstraints = NO;
            labelToAdd.textAlignment = NSTextAlignmentCenter;
            labelToAdd.layer.borderColor = [UIColor blackColor].CGColor;
            labelToAdd.layer.borderWidth = 1.0f;
            [_homeInningLabels setObject:labelToAdd atIndexedSubscript:x];
            views[[NSString stringWithFormat:@"homeInningView%i",x]] = labelToAdd;
            [self addSubview:labelToAdd];
        }
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:
                              @"H:|-[_dummyTeamLabel(50)]-0-[titleView0]-0-[titleView1(==titleView0)]-0-[titleView2(==titleView0)]-0-[titleView3(==titleView0)]-0-[titleView4(==titleView0)]-0-[titleView5(==titleView0)]-0-[titleView6(==titleView0)]-0-[titleView7(==titleView0)]-0-[titleView8(==titleView0)]-0-[_scoreLabel(==titleView0)]-0-[_hitsLabel(==titleView0)]-0-[_errorsLabel(==titleView0)]-|"
                              options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                              metrics:nil
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:
                              @"H:|-[_awayTeamLabel]-0-[awayInningView0]-0-[awayInningView1(==awayInningView0)]-0-[awayInningView2(==awayInningView0)]-0-[awayInningView3(==awayInningView0)]-0-[awayInningView4(==awayInningView0)]-0-[awayInningView5(==awayInningView0)]-0-[awayInningView6(==awayInningView0)]-0-[awayInningView7(==awayInningView0)]-0-[awayInningView8(==awayInningView0)]-0-[_awayScoreLabel(==awayInningView0)]-0-[_awayHitsLabel(==awayInningView0)]-0-[_awayErrorsLabel(==awayInningView0)]-|"
                              options:NSLayoutFormatAlignAllTop
                              metrics:nil
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:
                              @"H:|-[_homeTeamLabel]-0-[homeInningView0(homeInningView0)]-0-[homeInningView1(homeInningView0)]-0-[homeInningView2(homeInningView0)]-0-[homeInningView3(homeInningView0)]-0-[homeInningView4(homeInningView0)]-0-[homeInningView5(homeInningView0)]-0-[homeInningView6(homeInningView0)]-0-[homeInningView7(homeInningView0)]-0-[homeInningView8(homeInningView0)]-0-[_homeScoreLabel(homeInningView0)]-0-[_homeHitsLabel(homeInningView0)]-0-[_homeErrorsLabel(homeInningView0)]-|"
                              options:NSLayoutFormatAlignAllTop
                              metrics:nil
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleView0]-0-[awayInningView0]-0-[homeInningView0]-(>=1)-|"
                                                                     options:NSLayoutFormatAlignAllLeft
                                                                     metrics:nil
                                                                       views:views]];
    }
    
    return self;
}

@end
