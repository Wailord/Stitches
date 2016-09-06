//
//  STCFinalParser.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedParser.h"

@implementation STCFinalizedParser {
    NSXMLParser *_parser;
    STCFinalizedGame *_game;
}

-(void)parseFinalizedGameWithID:(NSString *)gameID {
    _parser = [[NSXMLParser alloc] init];
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
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [_parser setDelegate:self];
    [_parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"game"]) {
        NSLog(@"Started parsing a finalized game.");
        _game = [[STCFinalizedGame alloc] init];
        _game.awayTeamID = @"138";
        _game.awayTeamScore = [NSNumber numberWithInt:2];;
        _game.homeTeamID = @"141";
        _game.homeTeamScore = [NSNumber numberWithInt:4];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"game"]) {
        if(_delegate) {
            [_delegate parsedFinalizedGame:_game];
        }
    }
}

@end
