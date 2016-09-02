//
//  STGameSummaryTableViewCell.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummaryTableViewCell.h"
#import "STCSummaryTeamView.h"

@implementation STCSummaryTableViewCell {
    STCSummaryTeamView *_awayTeamView;
    STCSummaryTeamView *_homeTeamView;
    UILabel *_statusLabel;
}

- (instancetype)initWithGame:(STCSummary*)game{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"GameSummary"];
    
    if(self) {
        if(game.status == Preview) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        else {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        _awayTeamView = [[STCSummaryTeamView alloc] initWithTeamID:[game awayTeamID] andScore:[game awayScore]];
        _awayTeamView.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:_awayTeamView];
        
        _homeTeamView = [[STCSummaryTeamView alloc] initWithTeamID:[game homeTeamID] andScore:[game homeScore]];
        _homeTeamView.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:_homeTeamView];
        
        NSDictionary *teamViews = NSDictionaryOfVariableBindings(_awayTeamView, _homeTeamView);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_awayTeamView]-35-[_homeTeamView]"
                                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                                 metrics:nil
                                                                                   views:teamViews]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayTeamView]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:teamViews]];
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
        
        // align the status label to the left of the tableviewcell (so numbers line up)
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_statusLabel]-30-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_statusLabel)]];

        
        // center the status label in the tableviewcell
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel
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
