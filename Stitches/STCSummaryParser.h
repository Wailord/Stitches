//
//  STGameSummaryParser.h
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCBaseGame.h"

@protocol STCSummaryParserDelegate
@required
-(void)parsedGameSummary:(STCBaseGame *)summary;
-(void)parsedAllGameSummaries;
@end

@interface STCSummaryParser : NSObject
@property (nonatomic, weak) id<STCSummaryParserDelegate> delegate;

- (void)parseGameSummariesForYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day;

@end
