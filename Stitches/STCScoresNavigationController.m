//
//  ViewController.m
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCScoresPageViewController.h"
#import "STCScoresNavigationController.h"
#import "STCSummariesTableViewController.h"

@implementation STCScoresNavigationController {
    STCScoresPageViewController *_scoresPageViewController;
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
    
    _scoresPageViewController = [[STCScoresPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                       navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                     options:nil];
    [self pushViewController:_scoresPageViewController animated:false];
}

@end
