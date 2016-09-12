//
//  STParseMLB.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummaryParser.h"

@interface STCSummaryParser ()<NSXMLParserDelegate>
@end

@implementation STCSummaryParser {
    NSXMLParser *_parser;
    NSMutableArray *_summaryList;
    STCBaseGame *_summary;
}

-(void)parseGameSummariesForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    // if our month or date is less than ten, make sure the string prepends a zero (so each is always two characters)
    NSString *monthString = (month < 10) ? [NSString stringWithFormat:@"0%ld", (long)month] : [NSString stringWithFormat:@"%ld", (long)month];
    NSString *dateString = (day < 10) ? [NSString stringWithFormat:@"0%@", @(day)] : @(day).stringValue;
    
    // build the URL we're going to use to get current MLB scoreboard info
    NSString *xmlPath = [NSString stringWithFormat:@"http://gd2.mlb.com/components/game/mlb/year_%ld/month_%@/day_%@/miniscoreboard.xml",
                         (long)year,
                         monthString,
                         dateString];
    
    NSURL *url = [[NSURL alloc] initWithString:xmlPath];
    
    // set up and start up the XML parser
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    _parser.delegate = self;
    [_parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // once we find some games, initialize our mutable array of games
    if([elementName isEqualToString:@"games"]) {
        _summaryList = [NSMutableArray new];
    }
    else if([elementName isEqualToString:@"game"])
    {
        _summary = [[STCBaseGame alloc] initWithDictionary:attributeDict];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if(parser == _parser) {
        if([elementName isEqualToString:@"game"] && _summary != nil) {
            [_summaryList addObject:_summary];
            if(self.delegate) {
                [self.delegate parsedGameSummary:_summary];
            }
            _summary = nil;
        }
        else if([elementName isEqualToString:@"games"]) {
            if(self.delegate) {
                [self.delegate parsedAllGameSummaries];
            }
        }
    }
}
@end
