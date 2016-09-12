//
//  STGamePreview.h
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCPreviewTeam.h"
#import "STCVenue.h"

@interface STCPreview : NSObject

@property STCPreviewTeam *awayTeam;
@property STCPreviewTeam *homeTeam;
@property STCVenue *venue;
@property NSDate *startTime;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
