//
//  Constants.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

// currently supported game statuses
typedef NS_ENUM(NSInteger, STCGameStatus) {
    STCNoStatus,
    STCPreviewStatus,
    STCInProgressStatus,
    STCFinalizedStatus
};

typedef NS_ENUM(NSInteger, STCTeamType) {
    STCAwayTeam,
    STCHomeTeam,
};

@interface STCGlobals : NSObject

+(NSString *)abbreviationForTeamID:(NSString *)teamID;
+(NSString *)fullNameForTeamID:(NSString *)teamID;
+(NSString *)briefNameForTeamID:(NSString *)teamID;

@end
