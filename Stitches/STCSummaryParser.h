//
//  STGameSummaryParser.h
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCSummary.h"

@protocol STParserMLBGameSummaryDelegate
@required
-(void)parsedGameSummary:(STCSummary *)summary;
-(void)parsedAllGameSummaries;
@end

@interface STCSummaryParser : NSObject<NSXMLParserDelegate>
@property (nonatomic, weak) id<STParserMLBGameSummaryDelegate> delegate;

- (void)parseGameSummariesForYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day;

@end
