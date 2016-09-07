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
    _gameSummaries = [[NSMutableArray alloc] init];
    
    _parser = [[STCSummaryParser alloc] init];
    [_parser setDelegate:self];
    [self parseGames];
    
    self.tableView.rowHeight = 84;
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    self.navigationItem.title = _scoreboardDate.description;
}

- (instancetype)initWithDateComponents:(NSDateComponents *)components {
    self = [super init];
    if(self) {
        _scoreboardDate = components;
    }
    
    return self;
}

- (void)parsedGameSummary:(STCSummary *)summary {
    [self.gameSummaries addObject:summary];
    //NSLog(@"Parsed game summary: %@", summary);
    [self.tableView reloadData];
}

- (void)parseGames {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_parser parseGameSummariesForYear:_scoreboardDate.year
                                  andMonth:_scoreboardDate.month
                                    andDay:_scoreboardDate.day];
    });
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
        case STCFinalizedStatus:
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
        cell.homeName = [STCGlobals getAbbreviationForTeamID:[game homeTeamID]];
        cell.homeScore = game.homeScore;
        cell.awayName = [STCGlobals getAbbreviationForTeamID:[game awayTeamID]];
        cell.awayScore = game.awayScore;
    }
        
    return cell;
}

@end
