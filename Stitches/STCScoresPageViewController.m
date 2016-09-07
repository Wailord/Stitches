//
//  STCSummariesPageViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCScoresPageViewController.h"

@interface STCScoresPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate> {
    NSArray *_scoreDays;
    NSDateFormatter *_formatter;
    NSCalendar *_gregorian;
    NSDateComponents *_oneDayBefore;
    NSDateComponents *_oneDayAfter;
}

@end

@implementation STCScoresPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"EEEE, MMMM d";
    _gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    _oneDayBefore = [[NSDateComponents alloc] init];
    [_oneDayBefore setDay:-1];
    
    _oneDayAfter = [[NSDateComponents alloc] init];
    [_oneDayAfter setDay:1];
    
    self.dataSource = self;
    self.delegate = self;
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Scores"
                                                    image:[UIImage imageNamed:@"baseball.png"]
                                                      tag:0];
    
    self.navigationItem.title = [_formatter stringFromDate:[NSDate date]];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // the scoreboard nav controller, which will have a tableview
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                fromDate:[NSDate date]];
    
    _currentScoresTableViewController = [[STCSummariesTableViewController alloc] initWithDateComponents:components];
    
    [self setViewControllers:@[_currentScoresTableViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:^(BOOL finished) { }];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    NSDateComponents *currentDateComponents = ((STCSummariesTableViewController *)([self.viewControllers firstObject])).scoreboardDate;
    NSDate *currentDate = [[NSCalendar currentCalendar] dateFromComponents:currentDateComponents];
    
    self.navigationItem.title = [_formatter stringFromDate:currentDate];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.navigationItem.title = @"";
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(STCSummariesTableViewController *)viewController {
    NSDate *currentlyDisplayedDate = nil;
    
    if(!viewController) {
        currentlyDisplayedDate = [NSDate date];
    }
    else {
        currentlyDisplayedDate = [_gregorian dateFromComponents:viewController.scoreboardDate];
    }
    
    NSDate *newDateToShow = [_gregorian dateByAddingComponents:_oneDayAfter
                                                         toDate:currentlyDisplayedDate
                                                        options:0];
    
    NSDateComponents *tomorrowComponents = [[NSCalendar currentCalendar]
                                            components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                            fromDate:newDateToShow];
    
    return [[STCSummariesTableViewController alloc] initWithDateComponents:tomorrowComponents];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(STCSummariesTableViewController *)viewController {
    NSDate *currentlyDisplayedDate = nil;
    
    if(!viewController) {
        currentlyDisplayedDate = [NSDate date];
    }
    else {
        currentlyDisplayedDate = [_gregorian dateFromComponents:viewController.scoreboardDate];
    }
    
    NSDate *newDateToShow = [_gregorian dateByAddingComponents:_oneDayBefore
                                                         toDate:currentlyDisplayedDate
                                                        options:0];
    
    NSDateComponents *yesterdayComponents = [[NSCalendar currentCalendar]
                                            components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                            fromDate:newDateToShow];
    
    return [[STCSummariesTableViewController alloc] initWithDateComponents:yesterdayComponents];
}



@end
