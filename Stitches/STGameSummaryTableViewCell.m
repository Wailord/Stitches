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

- (id)initWithInning:(NSNumber*)inn
       isTopOfInning:(BOOL)top
        homeTeamName:(NSString*)homeT
           homeScore:(NSNumber*)homeS
        awayTeamName:(NSString*)awayT
           awayScore:(NSNumber*)awayS
              status:(STGameStatus)gameStatus {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"GameSummary"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // AWAY TEAM
    // logo
    _awayLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baseball.png"]];
    [_awayLogo setFrame:CGRectMake(15.0f,4.0f,20.0f,20.0f)];
    
    // name
    _awayNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f,4.0f,100.0f,20.0f)];
    _awayNameLabel.text = awayT;
    [_awayNameLabel setAdjustsFontSizeToFitWidth:true];
    
    // score
    _awayScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(75.0f,4.0f,20.0f,20.0f)];
    _awayScoreLabel.text = [NSString stringWithFormat:@"%@", awayS];
    
    // HOME TEAM
    // logo
    _homeLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"standings.png"]];
    [_homeLogo setFrame:CGRectMake(15.0f,24.0f,20.0f,20.0f)];
    
    // name
    _homeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40.0f,24.0f,100.0f,20.0f)];
    _homeNameLabel.text = homeT;
    [_homeNameLabel setAdjustsFontSizeToFitWidth:true];
    
    // score
    _homeScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(75.0f,24.0f,20.0f,20.0f)];
    _homeScoreLabel.text = [NSString stringWithFormat:@"%@", homeS];
    
    
    // INNING INFO
    NSMutableString *inningText = [[NSMutableString alloc] initWithCapacity:6];
    if(gameStatus == Preview) {
        [inningText appendString:@"Pre-Game"];
    }
    else if(gameStatus == Final) {
        [inningText appendString:@"Final"];
    }
    else if(top) {
        [inningText appendString:@"Top "];
        [inningText appendString:[NSString stringWithFormat:@"%@", inn]];
    }
    else {
        [inningText appendString:@"Bot "];
        [inningText appendString:[NSString stringWithFormat:@"%@", inn]];
    }
    _inningLabel = [[UILabel alloc] initWithFrame:CGRectMake(140.0f,14.0f,100.0f,20.f)];
    _inningLabel.text = inningText;
    
    [self.contentView addSubview:_awayNameLabel];
    [self.contentView addSubview:_awayLogo];
    [self.contentView addSubview:_awayScoreLabel];
    
    [self.contentView addSubview:_homeNameLabel];
    [self.contentView addSubview:_homeLogo];
    [self.contentView addSubview:_homeScoreLabel];
    
    [self.contentView addSubview:_inningLabel];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
