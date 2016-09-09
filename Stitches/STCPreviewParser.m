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
    //NSLog(@"Began parsing game preview.");
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
        //NSLog(@"Started parsing preview game.");
        _preview = [[STCPreview alloc] init];
        _preview.awayTeam.teamID = [attributeDict objectForKey:@"away_team_id"];
        _preview.homeTeam.teamID = [attributeDict objectForKey:@"home_team_id"];
        _preview.awayTeam.teamRecord.wins = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_win"] integerValue]];
        _preview.awayTeam.teamRecord.losses = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_loss"] integerValue]];
        _preview.homeTeam.teamRecord.wins = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_win"] integerValue]];
        _preview.homeTeam.teamRecord.losses = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_loss"] integerValue]];
        
        // venue
        STCVenue *venue = [[STCVenue alloc] init];
        venue.venueID = [attributeDict objectForKey:@"venue_id"];
        venue.name = [attributeDict objectForKey:@"venue"];
        venue.location = [attributeDict objectForKey:@"location"];
        _preview.venue = venue;
    }
    else if([elementName isEqualToString:@"home_probable_pitcher"] || [elementName isEqualToString:@"away_probable_pitcher"]) {
        //NSLog(@"Started parsing a probable pitcher.");
        STCPitcher *_previewPitcher = [[STCPitcher alloc] init];
        NSString *firstName = [attributeDict objectForKey:@"first_name"];
        NSString *lastName = [attributeDict objectForKey:@"last_name"];
        _previewPitcher.firstName = firstName;
        _previewPitcher.lastName = lastName;
        
        _previewPitcher.playerID = [attributeDict objectForKey:@"id"];
        
        NSString *playerNumber = [attributeDict objectForKey:@"number"];
        NSString *playerERA = [attributeDict objectForKey:@"era"];
        NSString *wins = [attributeDict objectForKey:@"wins"];
        NSString *losses = [attributeDict objectForKey:@"losses"];
        NSString *throwingHand = [attributeDict objectForKey:@"throwinghand"];
        _previewPitcher.number = playerNumber;
        _previewPitcher.era = playerERA;
        _previewPitcher.wins = wins;
        _previewPitcher.losses = losses;
        _previewPitcher.throwingHand = throwingHand;
        
        if([elementName isEqualToString:@"away_probable_pitcher"]) {
            _preview.awayTeam.probablePitcher = _previewPitcher;
        }
        else {
            _preview.homeTeam.probablePitcher = _previewPitcher;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"game"] && _preview != nil) {
        if(_delegate) {
            //NSLog(@"%@", _preview);
            //NSLog(@"Done parsing preview.");
            [_delegate parsedGamePreview:_preview];
        }
        _preview = nil;
    }
}
@end
