//
//  STGameSummaryTableViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCSummariesTableViewController.h"
#import "STCBaseGame.h"
#import "STCFinalizedViewController.h"
#import "STCSummaryTableViewCell.h"
#import "STCPreviewViewController.h"
#import "STCInProgressViewController.h"

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

- (void)parsedGameSummary:(STCBaseGame *)summary {
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
    UIViewController *newView = nil;
    switch([_gameSummaries[indexPath.row] status])
    {
        case STCPreviewStatus:
            newView = [[STCPreviewViewController alloc] initWithGameID:[_gameSummaries[indexPath.row] gameID]];
            [self.navigationController pushViewController:newView animated:true];
            break;
        case STCFinalizedStatus:
            newView = [[STCFinalizedViewController alloc] initWithGameID:[_gameSummaries[indexPath.row] gameID]];
            break;
        case STCInProgressStatus:
            newView = [[STCInProgressViewController alloc] initWithGameID:[_gameSummaries[indexPath.row] gameID]];
            break;
        default:
            NSLog(@"ERROR: Tapped an unsupported game status. Creating a blank view.");
            newView = [[UIViewController alloc] init];
            break;
    }
    
    [self.navigationController pushViewController:newView animated:true];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STCSummaryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"summary"];
    
    STCBaseGame *game = self.gameSummaries[indexPath.row];
    
    if(cell == nil) {
        cell = [[STCSummaryTableViewCell alloc] initWithGame:(STCBaseGame *)game];
    }
    else {
        cell.inning = game.inning;
        cell.homeName = [STCGlobals getAbbreviationForTeamID:game.homeTeam.teamID];
        cell.homeScore = game.homeTeam.runsScored;
        cell.awayName = [STCGlobals getAbbreviationForTeamID:game.awayTeam.teamID];
        cell.awayScore = game.awayTeam.runsScored;
    }
        
    return cell;
}

@end
