//
//  STCPreviewView.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewTeamView.h"

@implementation STCPreviewTeamView

-(instancetype)init {
    self = [super init];
    if(self) {
        // team logo
        _teamLogoView = [[UIImageView alloc] init];
        _teamLogoView.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamLogoView];
        
        // gray background
        _pitcherCardBackgroundView = [[UIView alloc] init];
        _pitcherCardBackgroundView.layer.borderColor = [UIColor blackColor].CGColor;
        _pitcherCardBackgroundView.layer.borderWidth = 1.0;
        _pitcherCardBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_pitcherCardBackgroundView];
        
        // team name/record
        _teamNameLabel = [[UILabel alloc] init];
        _teamNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamNameLabel];
        
        _teamRecordLabel = [[UILabel alloc] init];
        _teamRecordLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamRecordLabel];
        
        // pitcher win-loss
        _pitcherRecordLabel = [[UILabel alloc] init];
        _pitcherRecordLabel.translatesAutoresizingMaskIntoConstraints = false;
        [_pitcherCardBackgroundView addSubview:_pitcherRecordLabel];
        
        // pitcher era
        _pitcherERALabel = [[UILabel alloc] init];
        _pitcherERALabel.translatesAutoresizingMaskIntoConstraints = false;
        [_pitcherCardBackgroundView addSubview:_pitcherERALabel];
        
        // pitcher headshot
        _pitcherImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stats.png"]];
        _pitcherImageView.translatesAutoresizingMaskIntoConstraints = false;
        [_pitcherCardBackgroundView addSubview:_pitcherImageView];
        
        // pitcher name
        _pitcherNameLabel = [[UILabel alloc] init];
        _pitcherNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        [_pitcherCardBackgroundView addSubview:_pitcherNameLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_teamLogoView, _pitcherCardBackgroundView,
                                                             _pitcherRecordLabel, _pitcherERALabel,
                                                             _pitcherImageView, _teamNameLabel,
                                                             _pitcherNameLabel, _teamRecordLabel);
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_pitcherCardBackgroundView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1.f constant:0.f]];
        
        // stuff above the gray square
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_teamLogoView(40)]-[_teamNameLabel]-[_teamRecordLabel]-(>=8)-|"
                                                                     options:NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop
                                                                     metrics:nil
                                                                       views:views]];
        
        // stuff above the gray square
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_pitcherCardBackgroundView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_teamLogoView(40)]-[_pitcherCardBackgroundView]-|"
                                                                     options:NSLayoutFormatAlignAllLeft
                                                                     metrics:nil
                                                                       views:views]];
        
        // stuff within the outline
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_pitcherImageView]-[_pitcherNameLabel]-(>=8)-[_pitcherRecordLabel]-[_pitcherERALabel]-|"
                                                                     options:NSLayoutFormatAlignAllTop
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_pitcherImageView]-2-|"
                                                                     options:0                                                                     metrics:nil
                                                                       views:views]];
    }
    
    return self;
}

@end
