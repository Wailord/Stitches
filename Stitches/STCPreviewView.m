//
//  STCPreviewView.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewView.h"

@implementation STCPreviewView

-(instancetype)init {
    self = [super init];
    if(self) {
        // team logo[[attributeDict objectForKey:@"status"] isEqualToString:@"Preview"]
        _teamLogoView = [[UIImageView alloc] init];
        _teamLogoView.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamLogoView];
        
        // gray background
        _pitcherCardBackgroundView = [[UIView alloc] init];
        _pitcherCardBackgroundView.backgroundColor = [UIColor lightGrayColor];
        _pitcherCardBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_pitcherCardBackgroundView];
        
        // team name/record
        _teamInfoLabel = [[UILabel alloc] init];
        _teamInfoLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamInfoLabel];
        
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
                                                             _pitcherImageView, _teamInfoLabel,
                                                             _pitcherNameLabel);
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_pitcherCardBackgroundView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1.f constant:0.f]];
        
        // stuff above the gray square
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_teamLogoView(40)]-[_teamInfoLabel]|"
                                                                     options:NSLayoutFormatAlignAllBottom
                                                                     metrics:nil
                                                                       views:views]];
        
        // stuff above the gray square
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_pitcherCardBackgroundView]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_teamLogoView(40)]-[_pitcherCardBackgroundView]|"
                                                                     options:NSLayoutFormatAlignAllLeft
                                                                     metrics:nil
                                                                       views:views]];
        
        // stuff within the gray square
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_pitcherImageView]-[_pitcherNameLabel]-[_pitcherRecordLabel]|"
                                                                     options:NSLayoutFormatAlignAllTop
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_pitcherImageView]-[_pitcherERALabel]|"
                                                                     options:NSLayoutFormatAlignAllLeft                                                                     metrics:nil
                                                                       views:views]];
    }
    
    return self;
}

@end