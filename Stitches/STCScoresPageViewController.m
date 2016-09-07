//
//  STCSummariesPageViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCScoresPageViewController.h"

@interface STCScoresPageViewController () {
    NSArray *_scoreDays;
}

@end

@implementation STCScoresPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Scores"
                                                    image:[UIImage imageNamed:@"baseball.png"]
                                                      tag:0];
    
    // the scoreboard nav controller, which will have a tableview
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger year = [gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    NSInteger month = [gregorian component:NSCalendarUnitMonth fromDate:NSDate.date];
    NSInteger day = [gregorian component:NSCalendarUnitDay fromDate:NSDate.date];
    
    _scoresNavigationController = [[STCScoresNavigationController alloc]
                                   initWithYear:year andMonth:month andDate:day];

    [self setViewControllers:@[_scoresNavigationController]
                   direction:UIPageViewControllerNavigationDirectionForward | UIPageViewControllerNavigationDirectionReverse
                    animated:YES
                  completion:^(BOOL finished) { NSLog(@"Finished animating."); }];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(STCScoresNavigationController *)viewController {
    
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentlyDisplayedDate = [gregorian dateFromComponents:viewController.scoreboardDate];
    NSDate *nextDate = [currentlyDisplayedDate dateByAddingTimeInterval:60*60*24];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nextDate];

    return [[STCScoresNavigationController alloc] initWithYear:components.year andMonth:components.month andDate:components.day];
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(STCScoresNavigationController *)viewController {
    
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentlyDisplayedDate = [gregorian dateFromComponents:viewController.scoreboardDate];
    NSDate *nextDate = [currentlyDisplayedDate dateByAddingTimeInterval:-(60*60*24)];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:nextDate];
    
    return [[STCScoresNavigationController alloc] initWithYear:components.year andMonth:components.month andDate:components.day];
}



@end
