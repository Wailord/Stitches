//
//  STCFinalizedTeamView.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedTeamView.h"

@implementation STCFinalizedTeamView

- (instancetype)init {
    self = [super init];
    if(self) {
        _runsScoredLabel = [[UILabel alloc] init];
        _runsScoredLabel.text = @"5";
        _runsScoredLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_runsScoredLabel];
        
        _teamRecordLabel = [[UILabel alloc] init];
        _teamRecordLabel.text = @"RECORD HERE";
        _teamRecordLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_teamRecordLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_runsScoredLabel, _teamRecordLabel);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_runsScoredLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_teamRecordLabel]-[_runsScoredLabel]-|"
                                                                     options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                     metrics:nil
                                                                       views:views]];
    }
    
    return self;
}

@end
