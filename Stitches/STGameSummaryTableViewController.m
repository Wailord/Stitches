//
//  STGameSummaryTableViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGameSummaryTableViewController.h"
#import "STGameSummary.h"

@interface STGameSummaryTableViewController ()

@end

@implementation STGameSummaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Today's Games";
    
    STGameSummary *dummyGame = [[STGameSummary alloc] init];
    [dummyGame setInning:[NSNumber numberWithInt:1]];
    [dummyGame setAwayTeam:@"Milwaukee Brewers"];
    [dummyGame setAwayScore:[NSNumber numberWithInt:2]];
    [dummyGame setHomeTeam:@"Chicago Cubs"];
    [dummyGame setHomeScore:[NSNumber numberWithInt:4]];
    [dummyGame setTopOfInning:false];
    
    _gameSummaries = [[NSArray alloc] initWithObjects:dummyGame, nil];
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
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
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"summary"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                  reuseIdentifier:@"summary"];
    }

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    cell.textLabel.text = [[self.gameSummaries objectAtIndex:indexPath.row] description];
    
    return cell;
}

@end
