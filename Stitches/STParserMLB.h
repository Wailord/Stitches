//
//  STParseMLB.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STGameSummary.h"

@protocol STParserMLBDelegate
@optional

#pragma Home Delegate

-(void)parsedGameSummary:(STGameSummary *)summary;

@end

@interface STParserMLB : NSObject <NSXMLParserDelegate>
{
    NSXMLParser *_parser;
    NSMutableArray *_summaryList;
    STGameSummary *_summary;
}

@property id delegate;

- (id)delegate;
- (void)setDelegate:(id)newDelegate;
- (void)parseGameSummariesForYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day;
- (void)parserDidStartDocument:(NSXMLParser *)parser;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

@end
