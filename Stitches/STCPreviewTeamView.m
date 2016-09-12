//
//  STCPreviewView.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewTeamView.h"
#import "STCGlobals.h"

@implementation STCPreviewTeamView

-(instancetype)init {
    self = [super init];
    if(self) {
        // team logo
        _teamLogoView = [UIImageView new];
        _teamLogoView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_teamLogoView];
        
        // gray background
        _pitcherCardBackgroundView = [UIView new];
        _pitcherCardBackgroundView.layer.borderColor = [UIColor blackColor].CGColor;
        _pitcherCardBackgroundView.layer.borderWidth = 1.0;
        _pitcherCardBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_pitcherCardBackgroundView];
        
        // team name/record
        _teamNameLabel = [UILabel new];
        _teamNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _teamNameLabel.text = @"The Benchwarmers";
        [self addSubview:_teamNameLabel];
        
        _teamRecordLabel = [UILabel new];
        _teamRecordLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _teamRecordLabel.text = @"team record";
        [self addSubview:_teamRecordLabel];
        
        // pitcher win-loss
        _pitcherRecordLabel = [UILabel new];
        _pitcherRecordLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _pitcherRecordLabel.text = @"pitcher record";
        [_pitcherCardBackgroundView addSubview:_pitcherRecordLabel];
        
        // pitcher era
        _pitcherERALabel = [UILabel new];
        _pitcherERALabel.translatesAutoresizingMaskIntoConstraints = NO;
        _pitcherERALabel.text = @"pitcher ERA";
        [_pitcherCardBackgroundView addSubview:_pitcherERALabel];
        
        // pitcher headshot
        _pitcherImageView = [UIImageView new];
        _pitcherImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_pitcherCardBackgroundView addSubview:_pitcherImageView];
        
        // pitcher name
        _pitcherNameLabel = [UILabel new];
        _pitcherNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _pitcherNameLabel.text = @"pitcher name";
        [_pitcherCardBackgroundView addSubview:_pitcherNameLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_teamLogoView, _pitcherCardBackgroundView,
                                                             _pitcherRecordLabel, _pitcherERALabel,
                                                             _pitcherImageView, _teamNameLabel,
                                                             _pitcherNameLabel, _teamRecordLabel);
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_pitcherImageView
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:_pitcherImageView
                                                  attribute:NSLayoutAttributeWidth
                                                 multiplier:1.0f
                                                   constant:0.0f]];
        
        // stuff above the gray square
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_teamLogoView(40)]-[_teamNameLabel]-[_teamRecordLabel]-(>=8)-|"
                                                                     options:NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop
                                                                     metrics:nil
                                                                       views:views]];
        
        // the box holding the pitcher info
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_pitcherCardBackgroundView]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_teamLogoView(40)]-[_pitcherCardBackgroundView]-|"
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

- (void)setTeam:(STCPreviewTeam *)team {
    // away team view setup
    _teamLogoView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",team.teamID]];
    _teamNameLabel.text = [STCGlobals fullNameForTeamID:team.teamID];
    _teamRecordLabel.text = [NSString stringWithFormat:@"(%@-%@)",
                                                             team.teamRecord.wins,
                                                             team.teamRecord.losses];
    
    NSString *awayFullName = [NSString stringWithFormat:@"%@ %@",
                              team.probablePitcher.firstName,
                              team.probablePitcher.lastName];
    NSString *awayPitcherRecord = [NSString stringWithFormat:@"%@-%@",
                                   team.probablePitcher.wins,
                                   team.probablePitcher.losses];
    _pitcherNameLabel.text = awayFullName;
    _pitcherERALabel.text = [NSString stringWithFormat:@"%@ ERA",team.probablePitcher.era];
    _pitcherRecordLabel.text = awayPitcherRecord;
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL:
                          [NSURL URLWithString:
                           [NSString stringWithFormat:@"http://mlb.mlb.com/images/players/assets/74_%@.png", team.probablePitcher.playerID]]];
    _pitcherImageView.image = [UIImage imageWithData: imageData];
}

@end
