//
//  STCPreviewPitcher.h
//  Stitches
//
//  Created by Ryan Fox on 9/5/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STCPitcher : NSObject

@property NSNumber *playerID;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *number;
@property NSString *throwingHand;
@property NSString *era;
@property NSString *wins;
@property NSString *losses;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
