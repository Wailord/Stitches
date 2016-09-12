//
//  STGameSummaryTableViewCell.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummaryTableViewCell.h"
#import "STCSummaryTeamView.h"
#import "STCGlobals.h"

@implementation STCSummaryTableViewCell {
    STCSummaryTeamView *_awayTeamView;
    STCSummaryTeamView *_homeTeamView;
    UILabel *_statusLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if(self) {
        _awayTeamView = [STCSummaryTeamView new];
        _awayTeamView.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView addSubview:_awayTeamView];
        
        _homeTeamView = [STCSummaryTeamView new];
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
        _statusLabel = [UILabel new];
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

- (void)setGame:(STCBaseGame*)game {
    bool awayTeamWon = (game.status == STCFinalizedStatus) && (game.awayTeam.runsScored > game.homeTeam.runsScored);
    bool homeTeamWon = (game.status == STCFinalizedStatus) && (game.awayTeam.runsScored < game.homeTeam.runsScored);
    
    if(awayTeamWon) {
        [_awayTeamView setTeamWon:YES];
    }
    if(homeTeamWon) {
        [_homeTeamView setTeamWon:YES];
    }
    
    [_awayTeamView setTeamID:game.awayTeam.teamID];
    [_homeTeamView setTeamID:game.homeTeam.teamID];
    [_awayTeamView setScore:game.awayTeam.runsScored];
    [_homeTeamView setScore:game.homeTeam.runsScored];
    
    if(game.status == STCPreviewStatus || game.status == STCFinalizedStatus) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // game status
    NSDateFormatter *formatter = nil;
    NSMutableString *statusText = [[NSMutableString alloc] initWithCapacity:6];
    switch(game.status) {
        case STCPreviewStatus:
            formatter = [NSDateFormatter new];
            formatter.dateFormat = @"h:mm a";
            [statusText appendString:[formatter stringFromDate:game.startTime]];
            break;
        case STCFinalizedStatus:
            [statusText appendString:@"Final"];
            if(![game.inning  isEqual: @(9)]) {
                [statusText appendString:[NSString stringWithFormat:@" (%@)", game.inning]];
            }
            break;
        case STCInProgressStatus:
            if(game.topOfInning) {
                [statusText appendString:@"Top "];
                [statusText appendString:[NSString stringWithFormat:@"%@", game.inning]];
            }
            else {
                [statusText appendString:@"Bot "];
                [statusText appendString:[NSString stringWithFormat:@"%@", game.inning]];
                break;
            }
        case STCNoStatus:
            [statusText appendString:@"Bugged!"];
            break;
    }
    
    _statusLabel.text = statusText;
}

- (void)setScore:(NSNumber *)score forTeam:(STCTeamType)type {
    switch(type) {
        case STCAwayTeam:
            [_awayTeamView setScore:score];
            break;
        case STCHomeTeam:
            [_homeTeamView setScore:score];
            break;
        default:
            break;
    }
}

- (void)setTeamID:(NSString *)teamID forTeam:(STCTeamType)type {
    switch(type) {
        case STCAwayTeam:
            [_awayTeamView setTeamID:teamID];
            break;
        case STCHomeTeam:
            [_homeTeamView setTeamID:teamID];
            break;
        default:
            break;
    }
}

- (void)setGameStatus:(NSString *)text {
    _statusLabel.text = text;
}

@end
