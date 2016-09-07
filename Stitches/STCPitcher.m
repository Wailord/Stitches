//
//  STCPreviewPitcher.m
//  Stitches
//
//  Created by Ryan Fox on 9/5/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPitcher.h"

@implementation STCPitcher

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ (%@-%@, %@ ERA)", _firstName, _lastName, _wins, _losses, _era];
}

@end
