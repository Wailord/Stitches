//
//  ViewController.m
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCScoresNavigationController.h"

@implementation STCScoresNavigationController {
    STCSummariesTableViewController *_gameSummaryTableViewController;
}

- (instancetype)initWithYear:(NSInteger)year andMonth:(NSInteger)month andDate:(NSInteger)date {
    self = [super init];
    if(self) {
        _scoreboardDate = [[NSDateComponents alloc] init];
        [_scoreboardDate setYear:year];
        [_scoreboardDate setMonth:month];
        [_scoreboardDate setDay:date];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _gameSummaryTableViewController = [[STCSummariesTableViewController alloc]
                                       initWithDateComponents:_scoreboardDate];
    
    [self pushViewController:_gameSummaryTableViewController
                    animated:false];
}

@end
