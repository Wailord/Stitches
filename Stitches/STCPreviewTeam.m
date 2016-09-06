//
//  STCPreviewTeam.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewTeam.h"

@implementation STCPreviewTeam

- (instancetype)init {
    self = [super init];
    if(self) {
        _probablePitcher = [[STCPreviewPitcher alloc] init];
        _teamRecord = [[STCTeamRecord alloc] init];
    }
    
    return self;
}

@end
