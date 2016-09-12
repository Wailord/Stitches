//
//  STCFinalizedTeam.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedTeam.h"

@implementation STCFinalizedTeam

- (instancetype)init {
    self = [super init];
    if(self) {
        _teamRecord = [STCTeamRecord new];
    }
    
    return self;
}

@end
