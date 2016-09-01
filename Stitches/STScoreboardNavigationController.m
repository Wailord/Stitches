//
//  ViewController.m
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STScoreboardNavigationController.h"

@interface STScoreboardNavigationController ()

@end

@implementation STScoreboardNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Scores"
                                                    image:[UIImage imageNamed:@"baseball.png"]
                                                      tag:0];
    _scoreboardTableViewController = [[UITableViewController alloc] init];
    _scoreboardTableViewController.title = @"Today's Games";
    
    [self pushViewController:_scoreboardTableViewController
                    animated:false];
    self.title = @"Scores";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
