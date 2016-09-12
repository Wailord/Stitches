//
//  STCPreview_m
//  Stitches
//
//  Created by Ryan Fox on 9/5/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPitcher.h"

@implementation STCPitcher

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        _playerID = dict[@"id"];
        _firstName = dict[@"first_name"];
        _lastName = dict[@"last_name"];
        _number = dict[@"number"];
        _throwingHand = dict[@"throwing_hand"];
        _wins = dict[@"wins"];
        _losses = dict[@"losses"];
        _era = dict[@"era"];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ (%@-%@, %@ ERA)", _firstName, _lastName, _wins, _losses, _era];
}

@end
