//
//  ViewController.m
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STScoreboardNavigationController.h"

@implementation STScoreboardNavigationController {
    STGameSummaryTableViewController *_gameSummaryTableViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Scores"
                                                    image:[UIImage imageNamed:@"baseball.png"]
                                                      tag:0];
    _gameSummaryTableViewController = [[STGameSummaryTableViewController alloc] init];
    
    [self pushViewController:_gameSummaryTableViewController
                    animated:false];
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
