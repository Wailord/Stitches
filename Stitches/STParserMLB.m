//
//  STParseMLB.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STParserMLB.h"

@implementation STParserMLB

@synthesize delegate;

- (id)delegate {
    return delegate;
}
- (void)setDelegate:(id)newDelegate {
    delegate = newDelegate;
}

-(void)parseGameSummariesForYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day{
    NSString *monthS = (month < 10) ? [NSString stringWithFormat:@"0%ld", (long)month] : [NSString stringWithFormat:@"%ld", (long)month];
    NSString *dateS = (day < 10) ? [NSString stringWithFormat:@"0%ld", (long)day] : [NSString stringWithFormat:@"%ld", (long)day];
    
    NSString *xmlPath = [NSString stringWithFormat:@"http://gd2.mlb.com/components/game/mlb/year_%ld/month_%@/day_%@/miniscoreboard.xml",
                         (long)year,
                         monthS,
                         dateS];
    NSLog(@"using XMLpath = %@", xmlPath);
    NSURL *url = [[NSURL alloc] initWithString:xmlPath];
    _parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [_parser setDelegate:self];
    [_parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"Started parsing.");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"games"]) {
        _summaryList = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"game"])
    {
        bool validGame = false;
        STGameStatus status = NoStatus;
        if([[attributeDict objectForKey:@"status"] isEqualToString:@"In Progress"]) {
            status = InProgress;
            validGame = true;
        }
        else if([[attributeDict objectForKey:@"status"] isEqualToString:@"Preview"]) {
            status = Preview;
            validGame = true;
        }
        else if([[attributeDict objectForKey:@"status"] isEqualToString:@"Final"]) {
            status = Final;
            validGame = true;
        }
        
        if(validGame) {
            _summary = [[STGameSummary alloc] init];
            _summary.status = status;
            _summary.awayScore = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"away_team_runs"] integerValue]];
            _summary.homeScore = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"home_team_runs"] integerValue]];
            
            _summary.homeTeam = [attributeDict objectForKey:@"home_name_abbrev"];
            _summary.awayTeam = [attributeDict objectForKey:@"away_name_abbrev"];
            
            _summary.inning = [NSNumber numberWithInteger:[[attributeDict objectForKey:@"inning"] integerValue]];
            _summary.topOfInning = [[[attributeDict objectForKey:@"top_of_inning"] stringValue] isEqualToString:@"Y"];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"game"] && _summary != nil) {
        [_summaryList addObject:_summary];
        NSLog(@"Added a game: %@",_summary);
        if(delegate) {
            [delegate parsedGameSummary:_summary];
        }
        _summary = nil;
    }
}
@end
