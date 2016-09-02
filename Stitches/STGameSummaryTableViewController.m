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
    STGameSummaryParser *_parser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Today's Games";
    _gameSummaries = [[NSMutableArray alloc] init];
    
    _parser = [[STGameSummaryParser alloc] init];
    [_parser setDelegate:self];
    [self parseGames];
    
    self.tableView.rowHeight = 84;
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}

- (void)parsedGameSummary:(STGameSummary *)summary {
    [self.gameSummaries addObject:summary];
    [self.tableView reloadData];
}

- (void)parseGames {
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger year = [gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    NSInteger month = [gregorian component:NSCalendarUnitMonth fromDate:NSDate.date];
    NSInteger day = [gregorian component:NSCalendarUnitDay fromDate:NSDate.date];
    
    [_parser parseGameSummariesForYear:year andMonth:month andDay:day];
}

- (void)parsedAllGameSummaries {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
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
        cell.homeName = [[[STConstants teamDict] objectForKey:[game homeTeamID]] abbreviation];
        cell.homeScore = game.homeScore;
        cell.awayName = [[[STConstants teamDict] objectForKey:[game awayTeamID]] abbreviation];
        cell.awayScore = game.awayScore;
    }
        
    return cell;
}

@end
