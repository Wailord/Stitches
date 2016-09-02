//
//  STParseMLB.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STGamePreview.h"

@protocol STParserMLBGamePreviewDelegate
@required
-(void)parsedGamePreview:(STGamePreview *)preview;
@end

@interface STGamePreviewParser : NSObject <NSXMLParserDelegate>
@property (nonatomic, weak) id<STParserMLBGamePreviewDelegate> delegate;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parsePreviewWithGameID:(NSString *)gameID;

@end
