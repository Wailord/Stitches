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

@interface STCSummariesTableViewController ()<STCSummaryParserDelegate>
@end

@implementation STCSummariesTableViewController {
    STCSummaryParser *_parser;
    NSMutableArray<STCBaseGame*> *_gameSummaries;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _gameSummaries = [NSMutableArray<STCBaseGame*> new];
    
    _parser = [STCSummaryParser new];
    _parser.delegate = self;
    [self parseGames];
    
    self.tableView.rowHeight = 84;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.title = _scoreboardDate.description;
    
    [self.tableView registerClass:[STCSummaryTableViewCell class] forCellReuseIdentifier:@"GameSummary"];
}

- (instancetype)initWithDateComponents:(NSDateComponents *)components {
    self = [super init];
    if(self) {
        _scoreboardDate = components;
    }
    
    return self;
}

- (void)parsedGameSummary:(STCBaseGame *)summary {
    [_gameSummaries addObject:summary];
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _gameSummaries.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    STCPreviewViewController *preview;
    STCFinalizedViewController *final;
    STCInProgressViewController *inProgress;
    
    switch(_gameSummaries[indexPath.row].status) {
        case STCPreviewStatus:
            preview = [[STCPreviewViewController alloc] initWithGameID:(_gameSummaries[indexPath.row]).gameID];
            [self.navigationController pushViewController:preview animated:true];
            break;
        case STCFinalizedStatus:
            final = [[STCFinalizedViewController alloc] initWithGameID:(_gameSummaries[indexPath.row]).gameID];
            [self.navigationController pushViewController:final animated:YES];
            break;
        default:
            inProgress = [[STCInProgressViewController alloc] initWithGameID:@"test"];
            [self.navigationController pushViewController:inProgress
                                                 animated:true];
            NSLog(@"Tapped an unsupported row.");
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STCSummaryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"GameSummary" forIndexPath:indexPath];
    [cell setGame:_gameSummaries[indexPath.row]];
    
    return cell;
}

@end
