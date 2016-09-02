//
//  STGameSummaryTableViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGameSummaryTableViewController.h"
#import "STGameSummary.h"
#import "STGameSummaryTableViewCell.h"
#import "STGamePreviewViewController.h"

@implementation STGameSummaryTableViewController {
    STParserMLB *_parser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Today's Games";
    _gameSummaries = [[NSMutableArray alloc] init];
    
    _parser = [[STParserMLB alloc] init];
    [_parser setSummaryDelegate:self];
    [self parseGames];
    
    self.tableView.rowHeight = 84;
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}

- (void)parsedGameSummary:(STGameSummary *)summary {
    [self.gameSummaries addObject:summary];
    [self.tableView reloadData];
}

- (void)parsedAllGameSummaries {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
}

- (void)parseGames {
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger year = [gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    NSInteger month = [gregorian component:NSCalendarUnitMonth fromDate:NSDate.date];
    NSInteger day = [gregorian component:NSCalendarUnitDay fromDate:NSDate.date];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
    [_parser parseGameSummariesForYear:year andMonth:month andDay:day];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _gameSummaries.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_gameSummaries[indexPath.row] status] == Preview) {
        STGamePreviewViewController *gameInfo = [[STGamePreviewViewController alloc] initWithGameID:[_gameSummaries[indexPath.row] gameID]];
        [self.navigationController pushViewController:gameInfo animated:true];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STGameSummaryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"summary"];
    
    STGameSummary *game = self.gameSummaries[indexPath.row];
    
    if(cell == nil) {
        cell = [[STGameSummaryTableViewCell alloc] initWithGame:(STGameSummary *)game];
    }
    else {
        cell.inning = game.inning;
        cell.homeName = [[STConstants teamDict] valueForKeyPath:[NSString stringWithFormat:@"%@.abbrev", [game homeTeamID]]];
        cell.homeScore = game.homeScore;
        cell.awayName = [[STConstants teamDict] valueForKeyPath:[NSString stringWithFormat:@"%@.abbrev", [game awayTeamID]]];
        cell.awayScore = game.awayScore;
    }
        
    return cell;
}

@end
