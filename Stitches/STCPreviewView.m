//
//  STCPreviewView.m
//  Stitches
//
//  Created by Ryan Fox on 9/9/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewView.h"
#import "STCPreviewTeamView.h"

@implementation STCPreviewView {
    STCPreviewTeamView *_awayPreviewTeamView;
    STCPreviewTeamView *_homePreviewTeamView;
    UILabel *_versusLabel;
    UILabel *_venueLabel;
    UILabel *_locationLabel;
    UILabel *_startTimeLabel;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _venueLabel = [[UILabel alloc] init];
        _venueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _venueLabel.textAlignment = NSTextAlignmentCenter;
        _venueLabel.text = @"T-Mobile Arena";
        [self addSubview:_venueLabel];
        
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        _locationLabel.text = @"Las Vegas, NV";
        [self addSubview:_locationLabel];
        
        _startTimeLabel = [[UILabel alloc] init];
        _startTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _startTimeLabel.textAlignment = NSTextAlignmentCenter;
        _startTimeLabel.text = @"12:00 PM";
        [self addSubview:_startTimeLabel];
        
        _versusLabel = [[UILabel alloc] init];
        _versusLabel.text = @"vs.";
        _versusLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        _versusLabel.textAlignment = NSTextAlignmentCenter;
        _versusLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_versusLabel];
        
        _awayPreviewTeamView = [[STCPreviewTeamView alloc] init];
        _awayPreviewTeamView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_awayPreviewTeamView];
        
        _homePreviewTeamView = [[STCPreviewTeamView alloc] init];
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

- (void)setVenueText:(NSString *)text {
    _venueLabel.text = text;
}

- (void)setLocationText:(NSString *)text {
    _locationLabel.text = text;
}

- (void)setStartTimeTextWithDate:(NSDate *)startTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"h:mm a";

    _startTimeLabel.text = [formatter stringFromDate:startTime];
}

- (void)setTeamLogoForID:(NSString *)teamID forTeamType:(STCTeamType)type{
    switch(type) {
        case STCAwayTeam:
            _awayPreviewTeamView.teamLogoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", teamID]];
            break;
        case STCHomeTeam:
            _homePreviewTeamView.teamLogoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", teamID]];
            break;
        default:
            NSLog(@"Error: Received an STCTeamType of %ld while trying to set team logo to ID %@.", type, teamID);
            break;
    }
}
- (void)setTeamNameText:(NSString *)teamName forTeamType:(STCTeamType)type{
    switch(type) {
        case STCAwayTeam:
            _awayPreviewTeamView.teamNameLabel.text = teamName;
            break;
        case STCHomeTeam:
            _homePreviewTeamView.teamNameLabel.text = teamName;
            break;
        default:
            NSLog(@"Error: Received an STCTeamType of %ld while trying to set team name to %@.", type, teamName);
            break;
    }
}
- (void)setTeamRecordText:(NSString *)recordText forTeamType:(STCTeamType)type{
    switch(type) {
        case STCAwayTeam:
            _awayPreviewTeamView.teamRecordLabel.text = recordText;
            break;
        case STCHomeTeam:
            _homePreviewTeamView.teamRecordLabel.text = recordText;
            break;
        default:
            NSLog(@"Error: Received an STCTeamType of %ld while trying to set record text to %@.", type, recordText);
            break;
    }
}
- (void)setProbablePitcherNameText:(NSString *)text forTeamType:(STCTeamType)type {
    switch(type) {
        case STCAwayTeam:
            _awayPreviewTeamView.pitcherNameLabel.text = text;
            break;
        case STCHomeTeam:
            _homePreviewTeamView.pitcherNameLabel.text = text;
            break;
        default:
            NSLog(@"Error: Received an STCTeamType of %ld while trying to set probable pitcher name text to %@.", type, text);
            break;
    }
}
- (void)setProbablePitcherERAText:(NSString *)text forTeamType:(STCTeamType)type {
    switch(type) {
        case STCAwayTeam:
            _awayPreviewTeamView.pitcherERALabel.text = text;
            break;
        case STCHomeTeam:
            _homePreviewTeamView.pitcherERALabel.text = text;
            break;
        default:
            NSLog(@"Error: Received an STCTeamType of %ld while trying to set probable pitcher ERA text to %@.", type, text);
            break;
    }
}
- (void)setProbablePitcherRecordText:(NSString *)text forTeamType:(STCTeamType)type {
    switch(type) {
        case STCAwayTeam:
            _awayPreviewTeamView.pitcherRecordLabel.text = text;
            break;
        case STCHomeTeam:
            _homePreviewTeamView.pitcherRecordLabel.text = text;
            break;
        default:
            NSLog(@"Error: Received an STCTeamType of %ld while trying to set probable pitcher record text to %@.", type, text);
            break;
    }
}
- (void)setProbablePitcherImageForID:(NSNumber *)playerID forTeamType:(STCTeamType)type {
    // away pitcher picture
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:
                          [NSURL URLWithString:
                           [NSString stringWithFormat:@"http://mlb.mlb.com/images/players/assets/74_%@.png", playerID]]];
    switch(type) {
        case STCAwayTeam:
            _awayPreviewTeamView.pitcherImageView.image = [UIImage imageWithData: imageData];
            break;
        case STCHomeTeam:
            _homePreviewTeamView.pitcherImageView.image = [UIImage imageWithData: imageData];
            break;
        default:
            NSLog(@"Error: Received an STCTeamType of %ld while trying to set probable pitcher image for ID %@.", type, playerID);
            break;
    }
}

@end
