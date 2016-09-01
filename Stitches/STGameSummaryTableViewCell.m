//
//  STGameSummaryTableViewCell.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGameSummaryTableViewCell.h"

@implementation STGameSummaryTableViewCell

@synthesize homeScore;
@synthesize homeName;
@synthesize awayScore;
@synthesize awayName;
@synthesize inning;

- (id)initWithGame:(STGameSummary*)game{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"GameSummary"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // AWAY TEAM
    // logo
    _awayLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baseball.png"]];
    _awayLogo.translatesAutoresizingMaskIntoConstraints = false;
    //[self.contentView addSubview:_awayLogo];
    
    // name
    _awayNameLabel = [[UILabel alloc] init];
    _awayNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    _awayNameLabel.text = [game awayTeam];
    [self.contentView addSubview:_awayNameLabel];
    
    // score
    _awayScoreLabel = [[UILabel alloc] init];
    _awayScoreLabel.translatesAutoresizingMaskIntoConstraints = false;
    _awayScoreLabel.text = [NSString stringWithFormat:@"%@", [game awayScore]];
    [self.contentView addSubview:_awayScoreLabel];
    
    // HOME TEAM
    // logo
    _homeLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"standings.png"]];
    _homeLogo.translatesAutoresizingMaskIntoConstraints = false;
    //[self.contentView addSubview:_homeLogo];
    
    // name
    _homeNameLabel = [[UILabel alloc] init];
    _homeNameLabel.translatesAutoresizingMaskIntoConstraints = false;
    _homeNameLabel.text = [game homeTeam];
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
    NSDictionary *views = NSDictionaryOfVariableBindings(_homeLogo,_homeNameLabel,_homeScoreLabel,_awayLogo,_awayNameLabel,_awayScoreLabel,_statusLabel);
    
    // home team row
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_homeNameLabel]-10-[_homeScoreLabel]"
                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                 metrics:nil
                                                                   views:views]];
    
    // status label row
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_statusLabel]-20-|"
                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                 metrics:nil
                                                                   views:views]];
    
    // away team row
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_awayNameLabel]-10-[_awayScoreLabel]"
                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                 metrics:nil
                                                                   views:views]];
    
    // team name column
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_awayNameLabel][_homeNameLabel]|"
                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                 metrics:nil
                                                                   views:views]];
    
    // team score column
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_awayScoreLabel][_homeScoreLabel]|"
                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                 metrics:nil
                                                                   views:views]];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
