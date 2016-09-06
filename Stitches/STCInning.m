//
//  Inning.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCInning.h"

@implementation STCInning

- (NSString *)description {
    NSString *away = nil;
    NSString *home = nil;
    
    if(_awayTeamScore == nil) {
        away = @"-";
    }
    else {
        away = [NSString stringWithFormat:@"%@", _awayTeamScore];
    }
    
    if(_homeTeamScore == nil) {
        home = @"-";
    }
    else {
        home = [NSString stringWithFormat:@"%@", _homeTeamScore];
    }
    
    return [NSString stringWithFormat:@"%@ - A: %@ | H: %@", _number, away, home];
}

@end
