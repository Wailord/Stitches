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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Tapped on %@", _gameSummaries[indexPath.row]);
    UIViewController *gameInfo = [[UIViewController alloc] init];
    gameInfo.view.backgroundColor = [UIColor whiteColor];
    UILabel *basicInfo = [[UILabel alloc] initWithFrame:CGRectMake(10,64,300,20)];
    basicInfo.text = [_gameSummaries[indexPath.row] description];
    [gameInfo.view addSubview:basicInfo];
    [self.navigationController pushViewController:gameInfo animated:true];
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
        NSLog(@"%@", [game homeTeamID]);
        cell.homeScore = game.homeScore;
        cell.awayName = [[STConstants teamDict] valueForKeyPath:[NSString stringWithFormat:@"%@.abbrev", [game awayTeamID]]];
        cell.awayScore = game.awayScore;
    }
        
    return cell;
}

@end
