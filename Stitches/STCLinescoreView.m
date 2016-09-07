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
        
        NSDictionary *metrics = @{@"height" : @(30)};
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[titleView0(height)]-0-[titleView1(height)]-0-[titleView2(height)]-0-[titleView3(height)]-0-[titleView4(height)]-0-[titleView5(height)]-0-[titleView6(height)]-0-[titleView7(height)]-0-[titleView8(height)]-0-[_scoreLabel(height)]-0-[_hitsLabel(height)]-0-[_errorsLabel(height)]-|"
                              options:NSLayoutFormatAlignAllTop
                              metrics:metrics
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[awayInningView0(height)]-0-[awayInningView1(height)]-0-[awayInningView2(height)]-0-[awayInningView3(height)]-0-[awayInningView4(height)]-0-[awayInningView5(height)]-0-[awayInningView6(height)]-0-[awayInningView7(height)]-0-[awayInningView8(height)]-0-[_awayScoreLabel(height)]-0-[_awayHitsLabel(height)]-0-[_awayErrorsLabel(height)]-|"
                              options:NSLayoutFormatAlignAllTop
                              metrics:metrics
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[homeInningView0(height)]-0-[homeInningView1(height)]-0-[homeInningView2(height)]-0-[homeInningView3(height)]-0-[homeInningView4(height)]-0-[homeInningView5(height)]-0-[homeInningView6(height)]-0-[homeInningView7(height)]-0-[homeInningView8(height)]-0-[_homeScoreLabel(height)]-0-[_homeHitsLabel(height)]-0-[_homeErrorsLabel(height)]-|"
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
