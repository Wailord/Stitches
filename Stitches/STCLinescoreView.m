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
    STCLinescoreInningLabel *_awayTeamLabel;
    STCLinescoreInningLabel *_homeTeamLabel;
    STCLinescoreInningLabel *_dummyTeamLabel;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        UILabel *labelToAdd;
        NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
        
        // create the arrays of views
        _titleInningLabels = [[NSMutableArray alloc] initWithCapacity:9];
        _awayInningLabels = [[NSMutableArray alloc] initWithCapacity:9];
        _homeInningLabels = [[NSMutableArray alloc] initWithCapacity:9];
        
        // create the team labels and the blank dummy label above
        _dummyTeamLabel = [[STCLinescoreInningLabel alloc] init];
        _dummyTeamLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [views setObject:_dummyTeamLabel forKey:@"_dummyTeamLabel"];
        [self addSubview:_dummyTeamLabel];
        
        _awayTeamLabel = [[STCLinescoreInningLabel alloc] init];
        _awayTeamLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [views setObject:_awayTeamLabel forKey:@"_awayTeamLabel"];
        [self addSubview:_awayTeamLabel];
        
        _homeTeamLabel = [[STCLinescoreInningLabel alloc] init];
        _homeTeamLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [views setObject:_homeTeamLabel forKey:@"_homeTeamLabel"];
        [self addSubview:_homeTeamLabel];
        
        // create the constant RHE labels
        _scoreLabel = [[STCLinescoreInningLabel alloc] init];
        _scoreLabel.text = @"R";
        _scoreLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [views setObject:_scoreLabel forKey:@"_scoreLabel"];
        [self addSubview:_scoreLabel];
        
        _hitsLabel = [[STCLinescoreInningLabel alloc] init];
        _hitsLabel.text = @"H";
        _hitsLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [views setObject:_hitsLabel forKey:@"_hitsLabel"];
        [self addSubview:_hitsLabel];

        _errorsLabel = [[STCLinescoreInningLabel alloc] init];
        _errorsLabel.text = @"E";
        _errorsLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [views setObject:_errorsLabel forKey:@"_errorsLabel"];
        [self addSubview:_errorsLabel];

        // create the variable RHE labels
        _awayHitsLabel = [[STCLinescoreInningLabel alloc] init];
        [views setObject:_awayHitsLabel forKey:@"_awayHitsLabel"];
        [self addSubview:_awayHitsLabel];
        
        _awayScoreLabel = [[STCLinescoreInningLabel alloc] init];
        [views setObject:_awayScoreLabel forKey:@"_awayScoreLabel"];
        [self addSubview:_awayScoreLabel];
        
        _awayErrorsLabel = [[STCLinescoreInningLabel alloc] init];
        [views setObject:_awayErrorsLabel forKey:@"_awayErrorsLabel"];
        [self addSubview:_awayErrorsLabel];
        
        _homeHitsLabel = [[STCLinescoreInningLabel alloc] init];
        [views setObject:_homeHitsLabel forKey:@"_homeHitsLabel"];
        [self addSubview:_homeHitsLabel];
        
        _homeScoreLabel = [[STCLinescoreInningLabel alloc] init];
        [views setObject:_homeScoreLabel forKey:@"_homeScoreLabel"];
        [self addSubview:_homeScoreLabel];
        
        _homeErrorsLabel = [[STCLinescoreInningLabel alloc] init];
        [views setObject:_homeErrorsLabel forKey:@"_homeErrorsLabel"];
        [self addSubview:_homeErrorsLabel];
        
        // build nine of the inning views
        for(int x = 0; x < 9; x++) {
            labelToAdd = [[STCLinescoreInningLabel alloc] init];
            [_titleInningLabels setObject:labelToAdd atIndexedSubscript:x];
            [views setObject:labelToAdd forKey:[NSString stringWithFormat:@"titleView%i",x]];
            [self addSubview:labelToAdd];
            
            labelToAdd = [[STCLinescoreInningLabel alloc] init];
            [_awayInningLabels setObject:labelToAdd atIndexedSubscript:x];
            [views setObject:labelToAdd forKey:[NSString stringWithFormat:@"awayInningView%i",x]];
            [self addSubview:labelToAdd];
            
            labelToAdd = [[STCLinescoreInningLabel alloc] init];
            [_homeInningLabels setObject:labelToAdd atIndexedSubscript:x];
            [views setObject:labelToAdd forKey:[NSString stringWithFormat:@"homeInningView%i",x]];
            [self addSubview:labelToAdd];
        }
        
        NSDictionary *metrics = @{@"width" : @(30)};
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[_dummyTeamLabel(width)]-0-[titleView0(width)]-0-[titleView1(width)]-0-[titleView2(width)]-0-[titleView3(width)]-0-[titleView4(width)]-0-[titleView5(width)]-0-[titleView6(width)]-0-[titleView7(width)]-0-[titleView8(width)]-0-[_scoreLabel(width)]-0-[_hitsLabel(width)]-0-[_errorsLabel(width)]-|"
                              options:NSLayoutFormatAlignAllTop
                              metrics:metrics
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[_awayTeamLabel(width)]-0-[awayInningView0(width)]-0-[awayInningView1(width)]-0-[awayInningView2(width)]-0-[awayInningView3(width)]-0-[awayInningView4(width)]-0-[awayInningView5(width)]-0-[awayInningView6(width)]-0-[awayInningView7(width)]-0-[awayInningView8(width)]-0-[_awayScoreLabel(width)]-0-[_awayHitsLabel(width)]-0-[_awayErrorsLabel(width)]-|"
                              options:NSLayoutFormatAlignAllTop
                              metrics:metrics
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[_homeTeamLabel(width)]-0-[homeInningView0(width)]-0-[homeInningView1(width)]-0-[homeInningView2(width)]-0-[homeInningView3(width)]-0-[homeInningView4(width)]-0-[homeInningView5(width)]-0-[homeInningView6(width)]-0-[homeInningView7(width)]-0-[homeInningView8(width)]-0-[_homeScoreLabel(width)]-0-[_homeHitsLabel(width)]-0-[_homeErrorsLabel(width)]-|"
                              options:NSLayoutFormatAlignAllTop
                              metrics:metrics
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleView0]-0-[awayInningView0]-0-[homeInningView0]"
                                                                     options:NSLayoutFormatAlignAllLeft
                                                                     metrics:metrics
                                                                       views:views]];
    }
    
    return self;
}

@end
