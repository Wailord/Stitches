//
//  STGameSummaryTableViewCell.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGameSummaryTableViewCell.h"

@implementation STGameSummaryTableViewCell {
    UIImageView *_awayLogoImageView;
    UIImageView *_homeLogoImageView;
    UILabel *_homeScoreLabel;
    UILabel *_homeNameLabel;
    UILabel *_awayScoreLabel;
    UILabel *_awayNameLabel;
    UILabel *_statusLabel;
}

- (instancetype)initWithGame:(STGameSummary*)game{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"GameSummary"];
    
    if(self) {
        if(game.status == Preview) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        else {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        // AWAY TEAM
        // logo
        _awayLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [game awayTeamID]]]];
        _awayLogoImageView.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:_awayLogoImageView];
        
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
        _homeLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [game homeTeamID]]]];
        _homeLogoImageView.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:_homeLogoImageView];
        
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
        NSDictionary *views = NSDictionaryOfVariableBindings(_homeLogoImageView,_homeNameLabel,_homeScoreLabel,
                                                             _awayLogoImageView,_awayNameLabel,_awayScoreLabel,
                                                             _statusLabel);
        
        // align the status label to the left of the tableviewcell (so numbers line up)
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_statusLabel]-30-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
        NSDictionary *metrics = @{@"height" : @(30)};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayLogoImageView(height)]-[_awayNameLabel(96)]-[_awayScoreLabel]"
                                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                                 metrics:metrics
                                                                                   views:views]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_homeLogoImageView(height)]-[_homeNameLabel(96)]-[_homeScoreLabel]"
                                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                                 metrics:metrics
                                                                                   views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_awayLogoImageView(height)]-[_homeLogoImageView(height)]"
                                                                                 options:0
                                                                                 metrics:metrics
                                                                                   views:views]];
        
        // center the status label in the tableviewcell
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
