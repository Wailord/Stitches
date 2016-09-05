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
        // dummy stuff for now
        _teamLogoView = [[UIImageView alloc] init];
        _teamLogoView.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamLogoView];
        
        _pitcherCardBackgroundView = [[UIView alloc] init];
        _pitcherCardBackgroundView.backgroundColor = [UIColor redColor];
        _pitcherCardBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_pitcherCardBackgroundView];
        
        _teamInfoLabel = [[UILabel alloc] init];
        _teamInfoLabel.text = @"Team Name";
        _teamInfoLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamInfoLabel];
        
        _pitcherRecordLabel = [[UILabel alloc] init];
        _pitcherRecordLabel.translatesAutoresizingMaskIntoConstraints = false;
        _pitcherRecordLabel.text = @"22-7";
        [_pitcherCardBackgroundView addSubview:_pitcherRecordLabel];
        
        _pitcherERALabel = [[UILabel alloc] init];
        _pitcherERALabel.translatesAutoresizingMaskIntoConstraints = false;
        _pitcherERALabel.text = @"3.93 ERA";
        [_pitcherCardBackgroundView addSubview:_pitcherERALabel];
        
        _pitcherImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stats.png"]];
        _pitcherImageView.translatesAutoresizingMaskIntoConstraints = false;
        [_pitcherCardBackgroundView addSubview:_pitcherImageView];
        
        _pitcherNameLabel = [[UILabel alloc] init];
        _pitcherNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        [_pitcherCardBackgroundView addSubview:_pitcherNameLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_teamLogoView, _pitcherCardBackgroundView,
                                                             _pitcherRecordLabel, _pitcherERALabel,
                                                             _pitcherImageView, _teamInfoLabel,
                                                             _pitcherNameLabel);
        
        // stuff above the gray square
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_teamLogoView(60)]-20-[_teamInfoLabel]"
                                                                     options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_teamLogoView(60)]-[_pitcherCardBackgroundView]|"
                                                                     options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                     metrics:nil
                                                                       views:views]];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_pitcherCardBackgroundView]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        // stuff within the gray square
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_pitcherNameLabel]-20-[_pitcherRecordLabel]"
                                                                     options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_pitcherRecordLabel]-20-[_pitcherERALabel]"
                                                                     options:NSLayoutFormatAlignAllRight| NSLayoutFormatAlignAllLeft
                                                                     metrics:nil
                                                                       views:views]];
    }
    
    return self;
}

@end
