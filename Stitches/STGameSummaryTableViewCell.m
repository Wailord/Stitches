//
//  STGameSummaryTableViewCell.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGameSummaryTableViewCell.h"

@implementation STGameSummaryTableViewCell

- (id)initWithGame:(STGameSummary*)game{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"GameSummary"];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    // AWAY TEAM
    // logo
    _awayLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [game awayTeamID]]]];
    _awayLogo.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:_awayLogo];
    
    // name
    _awayNameLabel = [[UILabel alloc] init];
    _awayNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    _awayNameLabel.text = [[STConstants teamDict] valueForKeyPath:[NSString stringWithFormat:@"%@.abbrev", [game awayTeamID]]];
    [self.contentView addSubview:_awayNameLabel];
    
    // score
    _awayScoreLabel = [[UILabel alloc] init];
    _awayScoreLabel.translatesAutoresizingMaskIntoConstraints = false;
    _awayScoreLabel.text = [NSString stringWithFormat:@"%@", [game awayScore]];
    [self.contentView addSubview:_awayScoreLabel];
    
    // HOME TEAM
    // logo
    _homeLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [game homeTeamID]]]];
    _homeLogo.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:_homeLogo];
    
    // name
    _homeNameLabel = [[UILabel alloc] init];
    _homeNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    _homeNameLabel.text = [[STConstants teamDict] valueForKeyPath:[NSString stringWithFormat:@"%@.abbrev", [game homeTeamID]]];
    [self.contentView addSubview:_homeNameLabel];
    
    // score
    _homeScoreLabel = [[UILabel alloc] init];
    _homeScoreLabel.translatesAutoresizingMaskIntoConstraints = false;
    _homeScoreLabel.text = [NSString stringWithFormat:@"%@", [game homeScore]];
    [self.contentView addSubview:_homeScoreLabel];
    
    // GAME STATUS INFO
    NSDateFormatter *formatter = nil;
    NSMutableString *statusText = [[NSMutableString alloc] initWithCapacity:6];
    switch([game status]) {
        case Preview:
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"h:mm a"];
            [statusText appendString:[formatter stringFromDate:[game startTime]]];
            break;
        case Final:
        [statusText appendString:@"Final"];
            break;
        case InProgress:
            if([game topOfInning]) {
        [statusText appendString:@"Top "];
        [statusText appendString:[NSString stringWithFormat:@"%@", [game inning]]];
            }
            else {
        [statusText appendString:@"Bot "];
        [statusText appendString:[NSString stringWithFormat:@"%@", [game inning]]];
                break;
            }
        case NoStatus:
            [statusText appendString:@"Bugged!"];
            break;
    }
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.text = statusText;
    _statusLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:_statusLabel];
    
    // set the layout
    NSDictionary *views = NSDictionaryOfVariableBindings(_homeLogo,_homeNameLabel,_homeScoreLabel,
                                                         _awayLogo,_awayNameLabel,_awayScoreLabel,
                                                         _statusLabel);
    
    // team logo should be aligned to the left of the tableviewcell
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayLogo(20)]"
                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                 metrics:nil
                                                                   views:views]];
    // team names should be aligned to the left of the tableviewcell
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-44-[_awayNameLabel]"
                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                 metrics:nil
                                                                   views:views]];
    // team scores should be aligned off of the left of the tableviewcell
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-140-[_awayScoreLabel]"
                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                 metrics:nil
                                                                   views:views]];
    // align the status label to the left of the tableviewcell (so numbers line up)
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_statusLabel]-30-|"
                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                 metrics:nil
                                                                   views:views]];
    // team logos should be stacked
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_awayLogo(20)][_homeLogo(20)]"
                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                 metrics:nil
                                                                   views:views]];
    // team names should be stacked
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_awayNameLabel][_homeNameLabel]"
                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                 metrics:nil
                                                                   views:views]];
    // team scores should be stacked
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_awayScoreLabel][_homeScoreLabel]"
                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                 metrics:nil
                                                                   views:views]];
    // center the status label in the tableviewcell
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.contentView
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
