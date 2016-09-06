//
//  STCTeamRecord.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCTeamRecord.h"

@implementation STCTeamRecord

- (NSString *)description {
    return [NSString stringWithFormat:@"%@-%@", _wins, _losses];
}

@end
