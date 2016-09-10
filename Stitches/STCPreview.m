//
//  STGamePreview.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreview.h"
#import "STCPitcher.h"

@implementation STCPreview

- (instancetype)init {
    self = [super init];
    if(self) {
        _awayTeam = [[STCPreviewTeam alloc] init];
        _homeTeam = [[STCPreviewTeam alloc] init];
    }
    
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"AWAY PROBABLE: %@; HOME PROBABLE: %@",
            self.awayTeam.probablePitcher,
            self.homeTeam.probablePitcher];
}

@end
