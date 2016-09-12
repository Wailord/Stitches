//
//  STCFinalizedTeamView.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedTeamView.h"

@implementation STCFinalizedTeamView {
    UIImageView *_teamLogoImageView;
    UILabel *_runsScoredLabel;
    UILabel *_teamNameLabel;
    UILabel *_teamInfoLabel;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _teamLogoImageView = [UIImageView new];
        _teamLogoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_teamLogoImageView];
        
        _teamNameLabel = [UILabel new];
        _teamNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _teamNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_teamNameLabel];
        
        _runsScoredLabel = [UILabel new];
        _runsScoredLabel.text = @"0";
        _runsScoredLabel.font = [UIFont boldSystemFontOfSize:32.0f];
        _runsScoredLabel.textAlignment = NSTextAlignmentCenter;
        _runsScoredLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_runsScoredLabel];
        
        _teamInfoLabel = [UILabel new];
        _teamInfoLabel.text = @"Team (0-0)";
        _teamInfoLabel.textAlignment = NSTextAlignmentCenter;
        _teamInfoLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_teamInfoLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_runsScoredLabel,_teamInfoLabel,_teamLogoImageView,_teamNameLabel);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_runsScoredLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_teamNameLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_teamInfoLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_teamLogoImageView(120)]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_teamLogoImageView(120)]-[_teamNameLabel]-[_teamInfoLabel]-[_runsScoredLabel]-|"
                                                                     options:NSLayoutFormatAlignAllCenterX
                                                                     metrics:nil
                                                                       views:views]];
    }
    
    return self;
}


- (void)setTeamNameText:(NSString *)text {
    _teamNameLabel.text = text;
}

- (void)setRunsScoredText:(NSString *)text {
    _runsScoredLabel.text = text;
}

- (void)setTeamLogoWithID:(NSString *)teamID {
    _teamLogoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", teamID]];
}

- (void)setTeamInfoText:(NSString *)text {
    _teamInfoLabel.text = text;
}

@end
