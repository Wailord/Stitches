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
        
        // team id
        _game.awayTeam.teamID = [attributeDict objectForKey:@"away_team_id"];
        _game.homeTeam.teamID = [attributeDict objectForKey:@"home_team_id"];;
        
        // runs scored
        _game.awayTeam.runsScored = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_team_runs"] integerValue]];
        _game.homeTeam.runsScored = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_team_runs"] integerValue]];
        
        // winner
        _game.awayTeamWon = (_game.awayTeam.runsScored > _game.homeTeam.runsScored);
        
        // team records
        _game.awayTeam.teamRecord.wins = [attributeDict objectForKey:@"away_win"];
        _game.awayTeam.teamRecord.losses = [attributeDict objectForKey:@"away_loss"];
        _game.homeTeam.teamRecord.wins = [attributeDict objectForKey:@"home_win"];
        _game.homeTeam.teamRecord.losses = [attributeDict objectForKey:@"home_loss"];
        
        // hits
        _game.awayTeam.hits = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_team_hits"] integerValue]];
        _game.homeTeam.hits = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_team_hits"] integerValue]];
        
        // errors
        _game.awayTeam.errors = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_team_errors"] integerValue]];
        _game.homeTeam.errors = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_team_errors"] integerValue]];
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
