//
//  STCTeamScoreView.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummaryTeamView.h"
#import "STCGlobals.h"

@implementation STCSummaryTeamView {
    UIImageView *_teamLogoImageView;
    UILabel *_teamNameLabel;
    UILabel *_teamScoreLabel;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        // AWAY TEAM
        // logo
        _teamLogoImageView = [UIImageView new];
        _teamLogoImageView.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamLogoImageView];
        
        // name
        _teamNameLabel = [UILabel new];
        _teamNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamNameLabel];
        
        // score
        _teamScoreLabel = [UILabel new];
        _teamScoreLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamScoreLabel];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_teamLogoImageView, _teamNameLabel, _teamScoreLabel);
        NSDictionary *metrics = @{@"height" : @(30)};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_teamLogoImageView(height)]-[_teamNameLabel(96)]-[_teamScoreLabel]"
                                                                     options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                     metrics:metrics
                                                                       views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_teamLogoImageView(height)]"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:views]];
    }
    
    return self;
}

- (void)setTeamID:(NSString *)teamID {
    _teamNameLabel.text = [STCGlobals briefNameForTeamID:teamID];
    _teamLogoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",teamID]];
}

-(void)setScore:(NSNumber *)score {
    _teamScoreLabel.text = [NSString stringWithFormat:@"%@", score];
}

- (void)setTeamWon:(BOOL)won {
    if(won) {
        _teamNameLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    else {
        _teamNameLabel.font = [UIFont systemFontOfSize:16];
    }
}

@end
