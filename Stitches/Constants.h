//
//  Constants.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

// currently supported game statuses
typedef enum STGameStatus : NSUInteger {
    NoStatus,
    Preview,
    InProgress,
    Final
} STGameStatus;

@interface Constants : NSObject

@end
