//
//  STGameSummaryTableViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummariesTableViewController.h"
#import "STCSummary.h"
#import "STCFinalizedViewController.h"
#import "STCSummaryTableViewCell.h"
#import "STCPreviewViewController.h"

@implementation STCSummariesTableViewController {
    STCSummaryParser *_parser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Today";
    _gameSummaries = [[NSMutableArray alloc] init];
    
    _parser = [[STCSummaryParser alloc] init];
    [_parser setDelegate:self];
    [self parseGames];
    
    self.tableView.rowHeight = 84;
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}

- (void)parsedGameSummary:(STCSummary *)summary {
    [self.gameSummaries addObject:summary];
    //NSLog(@"Parsed game summary: %@", summary);
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
    STCPreviewViewController *preview = nil;
    STCFinalizedViewController *final = nil;
    switch([_gameSummaries[indexPath.row] status])
    {
        case STCPreviewStatus:
            preview = [[STCPreviewViewController alloc] initWithGameID:[_gameSummaries[indexPath.row] gameID]];
            [self.navigationController pushViewController:preview animated:true];
            break;
        case STCFinalStatus:
            final = [[STCFinalizedViewController alloc] initWithGameID:[_gameSummaries[indexPath.row] gameID]];
            [self.navigationController pushViewController:final animated:true];
            break;
        default:
            NSLog(@"Tapped an unsupported row.");
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STCSummaryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"summary"];
    
    STCSummary *game = self.gameSummaries[indexPath.row];
    
    if(cell == nil) {
        cell = [[STCSummaryTableViewCell alloc] initWithGame:(STCSummary *)game];
    }
    else {
        cell.inning = game.inning;
        cell.homeName = [[[STCGlobals teamDict] objectForKey:[game homeTeamID]] abbreviation];
        cell.homeScore = game.homeScore;
        cell.awayName = [[[STCGlobals teamDict] objectForKey:[game awayTeamID]] abbreviation];
        cell.awayScore = game.awayScore;
    }
        
    return cell;
}

@end
