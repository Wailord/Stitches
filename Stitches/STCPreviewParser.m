//
//  STParseMLB.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCPreviewParser.h"
#import "STCPitcher.h"

@interface STCPreviewParser ()<NSXMLParserDelegate>
@end

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
    _previewParser.delegate = self;
    [_previewParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"game"]) {
        //NSLog(@"Started parsing preview game.");
        _preview = [[STCPreview alloc] init];
        _preview.awayTeam.teamID = attributeDict[@"away_team_id"];
        _preview.homeTeam.teamID = attributeDict[@"home_team_id"];
        _preview.awayTeam.teamRecord.wins = @([attributeDict[@"away_win"] integerValue]);
        _preview.awayTeam.teamRecord.losses = @([attributeDict[@"away_loss"] integerValue]);
        _preview.homeTeam.teamRecord.wins = @([attributeDict[@"home_win"] integerValue]);
        _preview.homeTeam.teamRecord.losses = @([attributeDict[@"home_loss"] integerValue]);
        
        // venue
        STCVenue *venue = [[STCVenue alloc] init];
        venue.venueID = attributeDict[@"venue_id"];
        venue.name = attributeDict[@"venue"];
        venue.location = attributeDict[@"location"];
        _preview.venue = venue;
        
        if(attributeDict[@"time_date"]) {
            // start setting up time info; we need to check both the time zone and am/pm
            NSString *timeZone = attributeDict[@"time_zone"];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            dateFormat.dateFormat = @"YYYY/MM/dd hh:mm";
            if([timeZone isEqualToString:@"ET"]) {
                dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"EDT"];
            }
            else if([timeZone isEqualToString:@"PT"]) {
                dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"PDT"];
            }
            else if([timeZone isEqualToString:@"CT"]) {
                dateFormat.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"CDT"];
            }
            
            // with the time zone set up, we can build the date
            NSDate *dte = [dateFormat dateFromString:attributeDict[@"time_date"]];
            
            // if MLB says the time was in PM, we need to add twelve hours to the time
            if([attributeDict[@"ampm"] isEqualToString:@"PM"]) {
                // add twelve hours for PM
                NSTimeInterval twelveHours = 12 * 60 * 60;
                dte = [dte dateByAddingTimeInterval:twelveHours];
            }
            
            // assign the start time after building the date
            _preview.startTime = dte;
        }

    }
    else if([elementName isEqualToString:@"home_probable_pitcher"] || [elementName isEqualToString:@"away_probable_pitcher"]) {
        //NSLog(@"Started parsing a probable pitcher.");
        STCPitcher *_previewPitcher = [[STCPitcher alloc] init];
        NSString *firstName = attributeDict[@"first_name"];
        NSString *lastName = attributeDict[@"last_name"];
        _previewPitcher.firstName = firstName;
        _previewPitcher.lastName = lastName;
        
        _previewPitcher.playerID = attributeDict[@"id"];
        
        NSString *playerNumber = attributeDict[@"number"];
        NSString *playerERA = attributeDict[@"era"];
        NSString *wins = attributeDict[@"wins"];
        NSString *losses = attributeDict[@"losses"];
        NSString *throwingHand = attributeDict[@"throwinghand"];
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
