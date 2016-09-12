//
//  StitchesTests.m
//  StitchesTests
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <XCTest/XCTest.h>
#include "STCSummaryParser.h"

@interface StitchesSummaryTests : XCTestCase<STCSummaryParserDelegate> {
    STCSummaryParser *_summaryParser;
    NSMutableArray *_summaryList;
    bool _allGameSummariesParsed;
    bool _done;
}

@end

@implementation StitchesSummaryTests

-(void)parsedAllGameSummaries {
    _allGameSummariesParsed = YES;
}

-(void)parsedGameSummary:(STCBaseGame *)summary {
    [_summaryList addObject:summary];
}

- (void)setUp {
    [super setUp];
    _summaryParser = [STCSummaryParser new];
    _summaryParser.delegate = self;
    
    _summaryList = [NSMutableArray new];
}

-(void)tearDown {
    [super tearDown];
}

- (void)testParsingDateInPast {
    [_summaryParser parseGameSummariesForYear:2016 month:5 day:4];
    
    XCTAssertEqual([_summaryList count], 15, @"Failed to parse all game summaries.");
}

// method to deal with timing problems within the unit
-(BOOL)testForCompletion:(NSTimeInterval)timeoutSecs {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
            break;
    } while (!_done);
    
    return _done;
}

@end
