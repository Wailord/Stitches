//
//  STCLinescoreView.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCLinescoreView.h"

@implementation STCLinescoreView {
    STCLinescoreInningLabel *_hitsLabel;
    STCLinescoreInningLabel *_scoreLabel;
    STCLinescoreInningLabel *_errorsLabel;
    STCLinescoreInningLabel *_dummyTeamLabel;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        STCLinescoreInningLabel *labelToAdd;
        NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
        
        // create the arrays of views
        _titleInningLabels = [[NSMutableArray<STCLinescoreInningLabel*> alloc] initWithCapacity:9];
        _awayInningLabels = [[NSMutableArray<STCLinescoreInningLabel*> alloc] initWithCapacity:9];
        _homeInningLabels = [[NSMutableArray<STCLinescoreInningLabel*> alloc] initWithCapacity:9];
        
        // create the team labels and the blank dummy label above
        _dummyTeamLabel = [[STCLinescoreInningLabel alloc] initWithBoldText:@" "];
        views[@"_dummyTeamLabel"] = _dummyTeamLabel;
        [self addSubview:_dummyTeamLabel];
        
        _awayTeamLabel = [[STCLinescoreInningLabel alloc] initWithBoldText:@"WWW" andFontSize:17.0f];
        views[@"_awayTeamLabel"] = _awayTeamLabel;
        [self addSubview:_awayTeamLabel];
        
        _homeTeamLabel = [[STCLinescoreInningLabel alloc] initWithBoldText:@"WWW" andFontSize:17.0f];
        views[@"_homeTeamLabel"] = _homeTeamLabel;
        [self addSubview:_homeTeamLabel];
        
        // create the constant RHE labels
        _scoreLabel = [[STCLinescoreInningLabel alloc] initWithBoldText:@"R"];
        views[@"_scoreLabel"] = _scoreLabel;
        [self addSubview:_scoreLabel];
        
        _hitsLabel = [[STCLinescoreInningLabel alloc] initWithBoldText:@"H"];
        views[@"_hitsLabel"] = _hitsLabel;
        [self addSubview:_hitsLabel];

        _errorsLabel = [[STCLinescoreInningLabel alloc] initWithBoldText:@"E"];
        views[@"_errorsLabel"] = _errorsLabel;
        [self addSubview:_errorsLabel];

        // create the variable RHE labels
        _awayHitsLabel = [[STCLinescoreInningLabel alloc] init];
        views[@"_awayHitsLabel"] = _awayHitsLabel;
        [self addSubview:_awayHitsLabel];
        
        _awayScoreLabel = [[STCLinescoreInningLabel alloc] initWithBoldText:@"0" andFontSize:17.0f];
        views[@"_awayScoreLabel"] = _awayScoreLabel;
        [self addSubview:_awayScoreLabel];
        
        _awayErrorsLabel = [[STCLinescoreInningLabel alloc] init];
        views[@"_awayErrorsLabel"] = _awayErrorsLabel;
        [self addSubview:_awayErrorsLabel];
        
        _homeHitsLabel = [[STCLinescoreInningLabel alloc] init];
        views[@"_homeHitsLabel"] = _homeHitsLabel;
        [self addSubview:_homeHitsLabel];
        
        _homeScoreLabel = [[STCLinescoreInningLabel alloc] initWithBoldText:@"0" andFontSize:17.0f];
        views[@"_homeScoreLabel"] = _homeScoreLabel;
        [self addSubview:_homeScoreLabel];
        
        _homeErrorsLabel = [[STCLinescoreInningLabel alloc] init];
        views[@"_homeErrorsLabel"] = _homeErrorsLabel;
        [self addSubview:_homeErrorsLabel];
        
        // build nine of the inning views
        for(int x = 0; x < 9; x++) {
            labelToAdd = [[STCLinescoreInningLabel alloc] init];
            _titleInningLabels[x] = labelToAdd;
            views[[NSString stringWithFormat:@"titleView%i",x]] = labelToAdd;
            [self addSubview:labelToAdd];
            
            labelToAdd = [[STCLinescoreInningLabel alloc] init];
            [_awayInningLabels setObject:labelToAdd atIndexedSubscript:x];
            views[[NSString stringWithFormat:@"awayInningView%i",x]] = labelToAdd;
            [self addSubview:labelToAdd];
            
            labelToAdd = [[STCLinescoreInningLabel alloc] init];
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
