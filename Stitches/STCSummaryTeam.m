//
//  STCSummaryTeam.m
//  Stitches
//
//  Created by Ryan Fox on 9/12/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummaryTeam.h"

@implementation STCSummaryTeam

- (instancetype)init {
    self = [super init];
    if(self) {
        _teamRecord = [[STCTeamRecord alloc] init];
    }
    
    return self;
}

@end
