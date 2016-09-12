//
//  STCFinalParser.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedParser.h"
#import "STCInning.h"
#import "STCTeamRecord.h"
#import "STCPitcher.h"
#import "STCSavePitcher.h"
#import "STCVenue.h"

@interface STCFinalizedParser ()<NSXMLParserDelegate>
@end

@implementation STCFinalizedParser {
    NSXMLParser *_parser;
    STCFinalizedGame *_game;
}

-(void)parseFinalizedGameWithID:(NSString *)gameID {
    _parser = [NSXMLParser new];
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
        //NSLog(@"Started parsing a finalized game.");
        _game = [[STCFinalizedGame alloc] initWithDictionary:attributeDict];
    }
    else if([elementName isEqualToString:@"linescore"]) {
        STCInning *newestInning = [[STCInning alloc] initWithDictionary:attributeDict];
        [_game.innings addObject:newestInning];
    }
    else if([elementName isEqualToString:@"winning_pitcher"] || [elementName isEqualToString:@"losing_pitcher"]) {
        STCPitcher *pitcher = [[STCPitcher alloc] initWithDictionary:attributeDict];
                
        if([elementName isEqualToString:@"winning_pitcher"]) {
            _game.winningPitcher = pitcher;
        }
        else {
            _game.losingPitcher = pitcher;
        }
    }
    else if([elementName isEqualToString:@"save_pitcher"] && ![[attributeDict objectForKey:@"id"] isEqualToString:@""]) {
        STCSavePitcher *pitcher = [[STCSavePitcher alloc] initWithDictionary:attributeDict];
        _game.savingPitcher = pitcher;
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"game"]) {
        if(_delegate) {
            //NSLog(@"Done parsing finalized game.");
            [_delegate parsedFinalizedGame:_game];
        }
    }
}

@end
