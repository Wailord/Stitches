//
//  STCTeamScoreView.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummaryTeamView.h"
#import "STCGlobals.h"

@implementation STCSummaryTeamView

-(instancetype)initWithTeamID:(NSString *)teamID andScore:(NSNumber *)score {
    self = [super init];
    if(self) {
        // AWAY TEAM
        // logo
        _teamLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", teamID]]];
        _teamLogoImageView.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_teamLogoImageView];
        
        // name
        _teamNameLabel = [[UILabel alloc] init];
        _teamNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        _teamNameLabel.text = [[[STCGlobals teamDict] objectForKey:teamID] abbreviation];
        [self addSubview:_teamNameLabel];
        
        // score
        _teamScoreLabel = [[UILabel alloc] init];
        _teamScoreLabel.translatesAutoresizingMaskIntoConstraints = false;
        _teamScoreLabel.text = [NSString stringWithFormat:@"%@", score];
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

@end
