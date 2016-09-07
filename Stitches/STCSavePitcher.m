//
//  STCSavePitcher.m
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSavePitcher.h"

@implementation STCSavePitcher

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ (%@ SV, %@ ERA)", [self firstName], [self lastName], [self saves], [self era]];
}

@end
