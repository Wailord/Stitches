//
//  STCFinalParser.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCFinalizedGame.h"
#import "STCInning.h"
#import "STCTeamRecord.h"
#import "STCPitcher.h"
#import "STCSavePitcher.h"

@protocol STCFinalizedParserDelegate
@required
-(void)parsedFinalizedGame:(STCFinalizedGame *)final;
@end

@interface STCFinalizedParser : NSObject<NSXMLParserDelegate>

@property (nonatomic, weak) id<STCFinalizedParserDelegate> delegate;

-(void)parseFinalizedGameWithID:(NSString *)gameID;

@end
