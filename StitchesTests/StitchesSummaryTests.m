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
    _summaryParser = [[STCSummaryParser alloc] init];
    _summaryParser.delegate = self;
    
    _summaryList = [[NSMutableArray alloc] init];
}

-(void)tearDown {
    [super tearDown];
}

- (void)testParsingDateInPast {
    [_summaryParser parseGameSummariesForYear:2016 andMonth:5 andDay:4];
    
    XCTAssertEqual([_summaryList count], 15, @"Failed to parse all game summaries.");
    
    XCTAssertTrue([[[_summaryList objectAtIndex:0] gameID] isEqualToString:@"2016/05/04/chnmlb-pitmlb-1"], @"Failed to correctly parse the game ID for the summary.");
    XCTAssertTrue([[[_summaryList objectAtIndex:0] awayTeamID] isEqualToString: @"112"], @"Failed to correctly parse the away team's ID for the summary.");
    XCTAssertTrue([[[_summaryList objectAtIndex:0] homeTeamID] isEqualToString:@"134"], @"Failed to correctly parse the home team's ID for the summary.");
    XCTAssertEqual([[_summaryList objectAtIndex:0] awayScoreLabel], [NSNumber numberWithInteger:6], @"Failed to correctly parse the away team's score for the summary.");
    XCTAssertEqual([[_summaryList objectAtIndex:0] homeScoreLabel], [NSNumber numberWithInteger:2], @"Failed to correctly parse the home team's score for the summary.");
    XCTAssertEqual([[_summaryList objectAtIndex:0] status], STCFinalStatus, @"Failed to correctly parse the game status for the summary.");
}

// method to deal with timing problems within the unit test
- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs {
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
            break;
    } while (!_done);
    
    return _done;
}

@end
