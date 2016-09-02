//
//  STGamePreview.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGamePreview.h"

@implementation STGamePreview

-(NSString *)description {
    return [NSString stringWithFormat:@"AWAY PROBABLE: %@; HOME PROBABLE: %@", self.awayProbablePitcher, self.homeProbablePitcher];
}

@end