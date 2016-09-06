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
        _game.awayTeamID = [attributeDict objectForKey:@"away_team_id"];
        _game.awayTeamScore = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_team_runs"] integerValue]];
        _game.homeTeamID = [attributeDict objectForKey:@"home_team_id"];;
        _game.homeTeamScore = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_team_runs"] integerValue]];
    }
    else if([elementName isEqualToString:@"linescore"]) {
        STCInning *newestInning = [[STCInning alloc] init];
        newestInning.number = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"inning"] integerValue]];
        
        if([[attributeDict objectForKey:@"away_inning_runs"] isEqualToString:@""]) {
            newestInning.awayTeamScore = nil;
        }
        else {
            newestInning.awayTeamScore = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_inning_runs"] integerValue]];
        }
        
        if([[attributeDict objectForKey:@"home_inning_runs"] isEqualToString: @""]) {
            newestInning.homeTeamScore = nil;
        }
        else {
            newestInning.homeTeamScore = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_inning_runs"] integerValue]];
        }
        
        [_game.innings addObject:newestInning];
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
