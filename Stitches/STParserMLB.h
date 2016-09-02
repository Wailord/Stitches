//
//  STParseMLB.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STGameSummary.h"
#import "STGamePreview.h"

@protocol STParserMLBGameSummaryDelegate
@required
-(void)parsedGameSummary:(STGameSummary *)summary;
-(void)parsedAllGameSummaries;
@end

@protocol STParserMLBGamePreviewDelegate
@required
-(void)parsedGamePreview:(STGamePreview *)preview;
@end

@interface STParserMLB : NSObject <NSXMLParserDelegate>
{
    NSXMLParser *_summaryParser;
    NSXMLParser *_previewParser;
    NSMutableArray *_summaryList;
    STGameSummary *_summary;
    STGamePreview *_preview;
}

@property id summaryDelegate;
@property id previewDelegate;

- (id)summaryDelegate;
- (void)setSummaryDelegate:(id)newSummaryDelegate;
- (id)previewDelegate;
- (void)setPreviewDelegate:(id)newPreviewDelegate;
- (void)parseGameSummariesForYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
-(void)parsePreviewWithGameID:(NSString *)gameID;

@end
