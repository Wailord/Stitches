//
//  STCPreviewView.m
//  Stitches
//
//  Created by Ryan Fox on 9/9/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewView.h"
#import "STCPreviewTeamView.h"

@implementation STCPreviewView

- (instancetype)init {
    self = [super init];
    if (self) {
        _venueLabel = [UILabel new];
        _venueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _venueLabel.textAlignment = NSTextAlignmentCenter;
        _venueLabel.text = @"T-Mobile Arena";
        [self addSubview:_venueLabel];
        
        _locationLabel = [UILabel new];
        _locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        _locationLabel.text = @"Las Vegas, NV";
        [self addSubview:_locationLabel];
        
        _startTimeLabel = [UILabel new];
        _startTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _startTimeLabel.textAlignment = NSTextAlignmentCenter;
        _startTimeLabel.text = @"12:00 PM";
        [self addSubview:_startTimeLabel];
        
        _versusLabel = [UILabel new];
        _versusLabel.text = @"vs.";
        _versusLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        _versusLabel.textAlignment = NSTextAlignmentCenter;
        _versusLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_versusLabel];
        
        _awayPreviewTeamView = [STCPreviewTeamView new];
        _awayPreviewTeamView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_awayPreviewTeamView];
        
        _homePreviewTeamView = [STCPreviewTeamView new];
        _homePreviewTeamView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_homePreviewTeamView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_awayPreviewTeamView, _versusLabel, _homePreviewTeamView,
                                                             _venueLabel, _locationLabel, _startTimeLabel);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_awayPreviewTeamView]-[_versusLabel]-[_homePreviewTeamView]-[_startTimeLabel]-[_venueLabel]-[_locationLabel]-(>=1)-|"
                                                                     options:NSLayoutFormatAlignAllCenterX
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayPreviewTeamView]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_homePreviewTeamView]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_versusLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_venueLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_locationLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_startTimeLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
    }
    
    return self;
}

@end
