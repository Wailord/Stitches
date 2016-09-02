//
//  STParseMLB.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewParser.h"

@implementation STCPreviewParser {
    NSXMLParser *_previewParser;
    STCPreview *_preview;
}

-(void)parsePreviewWithGameID:(NSString *)gameID {
    NSArray *components = [gameID componentsSeparatedByString:@"/"];
    NSString *year = components[0];
    NSString *month = components[1];
    NSString *date = components[2];
    NSMutableString *gID = [[NSMutableString alloc] initWithString:components[3]];
    [gID replaceOccurrencesOfString:@"-"
                         withString:@"_"
                            options:NSLiteralSearch
                              range:NSMakeRange(0,[components[3] length])];
    NSString *xmlPath = [NSString stringWithFormat:@"http://gd2.mlb.com/components/game/mlb/year_%@/month_%@/day_%@/gid_%@_%@_%@_%@/linescore.xml",
                         year,
                         month,
                         date,
                         year,
                         month,
                         date,
                         gID];
    NSURL *url = [[NSURL alloc] initWithString:xmlPath];
    
    // set up and start up the XML parser
    _previewParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [_previewParser setDelegate:self];
    [_previewParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"game"]) {
        _preview = [[STCPreview alloc] init];
    }
    else if([elementName isEqualToString:@"home_probable_pitcher"]) {
        NSString *firstName = [attributeDict objectForKey:@"first_name"];
        NSString *lastName = [attributeDict objectForKey:@"last_name"];
        _preview.homeProbablePitcher = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    }
    else if([elementName isEqualToString:@"away_probable_pitcher"]) {
        NSString *firstName = [attributeDict objectForKey:@"first_name"];
        NSString *lastName = [attributeDict objectForKey:@"last_name"];
        _preview.awayProbablePitcher = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"game"] && _preview != nil) {
        if(_delegate) {
            [_delegate parsedGamePreview:_preview];
        }
        _preview = nil;
    }
}
@end
