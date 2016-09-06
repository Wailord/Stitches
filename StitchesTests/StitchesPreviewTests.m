//
//  StitchesPreviewTests.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STCPreviewParser.h"

@interface StitchesPreviewTests<STCPreviewParserDelegate> : XCTestCase {
    STCPreviewParser *_parser;
    bool _done;
}

@end

@implementation StitchesPreviewTests

- (void)setUp {
    [super setUp];
    _parser = [[STCPreviewParser alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testParsingNonPreview {
    // todo
}

- (void)testParsingPreview {
    // todo
}

@end
