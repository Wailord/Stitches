//
//  Inning.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCInning.h"

@implementation STCInning

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        _number = [NSNumber numberWithInteger:[[dict objectForKey:@"inning"] integerValue]];
        
        if([dict[@"away_inning_runs"] isEqualToString:@""]) {
            _awayTeamScore = nil;
        }
        else {
            _awayTeamScore = [NSNumber numberWithInteger:[dict[@"away_inning_runs"] integerValue]];
        }
        
        if([dict[@"home_inning_runs"] isEqualToString: @""]) {
            _homeTeamScore = nil;
        }
        else {
            _homeTeamScore = [NSNumber numberWithInteger:[dict[@"home_inning_runs"] integerValue]];
        }
    }
    
    return self;
}

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
