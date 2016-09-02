//
//  Constants.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMLBTeam.h"

// currently supported game statuses
typedef NS_ENUM(NSInteger, STGameStatus) {
    NoStatus,
    Preview,
    InProgress,
    Final
};

@interface STConstants : NSObject

+(NSDictionary*)teamDict;

@end
