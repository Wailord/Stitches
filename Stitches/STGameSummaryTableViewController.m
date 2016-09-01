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

@interface STGameSummaryTableViewController ()

@end

@implementation STGameSummaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Today's Games";
    _gameSummaries = [[NSMutableArray alloc] init];
    
    _parser = [[STParserMLB alloc] init];
    [_parser setDelegate:self];
    [self parseGames];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STGameSummaryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"summary"];
    
    STGameSummary *game = self.gameSummaries[indexPath.row];
    
    if(cell == nil) {
        cell = [[STGameSummaryTableViewCell alloc] initWithInning:game.inning
                                                    isTopOfInning:game.topOfInning
                                                     homeTeamName:game.homeTeam
                                                        homeScore:game.homeScore
                                                     awayTeamName:game.awayTeam
                                                        awayScore:game.awayScore
                                                           status:game.status];
    }
    else {
        cell.inning = game.inning;
        cell.homeName = game.homeTeam;
        cell.homeScore = game.homeScore;
        cell.awayName = game.awayTeam;
        cell.awayScore = game.awayScore;
    }
        
    return cell;
}

@end
