//
//  STCSavePitcher.m
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSavePitcher.h"

@implementation STCSavePitcher

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if(self) {
        _saves = dict[@"saves"];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ (%@ SV, %@ ERA)", self.firstName, self.lastName, self.saves, self.era];
}

@end
