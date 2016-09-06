//
//  STCFinalizedTeamView.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedTeamView.h"

@implementation STCFinalizedTeamView

- (instancetype)init {
    self = [super init];
    if(self) {
        _runsScored = [[UILabel alloc] init];
        _runsScored.text = @"5";
        [self addSubview:_runsScored];
        
        _teamRecord = [[UILabel alloc] init];
        _teamRecord.text = @"RECORD HERE";
        [self addSubview:_teamRecord];
    }
    
    return self;
}

@end
