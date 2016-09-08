//
//  STCSummariesPageViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCScoresPageViewController.h"

@interface STCScoresPageViewController ()<UIPageViewControllerDataSource> {
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
    
    UIBarButtonItem *rightArrow = [[UIBarButtonItem alloc]
                                   initWithTitle:@"\U000025B6\U0000FE0E"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(rightArrowClicked)];
    [rightArrow setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = rightArrow;
    
    UIBarButtonItem *leftArrow = [[UIBarButtonItem alloc]
                                   initWithTitle:@"\U000025C0\U0000FE0E"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(leftArrowClicked)];
    [leftArrow setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = leftArrow;
    
    _formatter = [[NSDateFormatter alloc] init];
    _formatter.dateFormat = @"EEEE, MMMM d";
    _gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    _oneDayBefore = [[NSDateComponents alloc] init];
    [_oneDayBefore setDay:-1];
    
    _oneDayAfter = [[NSDateComponents alloc] init];
    [_oneDayAfter setDay:1];
    
    self.dataSource = self;
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

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(STCSummariesTableViewController *)viewController {
    NSDateComponents *dayAfter = [self getComponentsForDayAfterScoreboard:viewController];
    
    return [[STCSummariesTableViewController alloc] initWithDateComponents:dayAfter];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(STCSummariesTableViewController *)viewController {
    NSDateComponents *dayBefore = [self getComponentsForDayBeforeScoreboard:viewController];
    return [[STCSummariesTableViewController alloc] initWithDateComponents:dayBefore];
}

- (NSDateComponents *)getComponentsForDayBeforeScoreboard:(STCSummariesTableViewController *)scoreboard {
    NSDate *currentlyDisplayedDate = nil;
    
    if(!scoreboard) {
        currentlyDisplayedDate = [NSDate date];
    }
    else {
        currentlyDisplayedDate = [_gregorian dateFromComponents:scoreboard.scoreboardDate];
    }
    
    NSDate *newDateToShow = [_gregorian dateByAddingComponents:_oneDayBefore
                                                        toDate:currentlyDisplayedDate
                                                       options:0];
    
    NSDateComponents *dayBeforeComponents = [[NSCalendar currentCalendar]
                                             components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                             fromDate:newDateToShow];
    return dayBeforeComponents;
}

- (NSDateComponents *)getComponentsForDayAfterScoreboard:(STCSummariesTableViewController *)scoreboard {
    NSDate *currentlyDisplayedDate = nil;
    
    if(!scoreboard) {
        currentlyDisplayedDate = [NSDate date];
    }
    else {
        currentlyDisplayedDate = [_gregorian dateFromComponents:scoreboard.scoreboardDate];
    }
    
    NSDate *newDateToShow = [_gregorian dateByAddingComponents:_oneDayAfter
                                                        toDate:currentlyDisplayedDate
                                                       options:0];
    
    NSDateComponents *dayAfterComponents = [[NSCalendar currentCalendar]
                                             components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                             fromDate:newDateToShow];
    return dayAfterComponents;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers direction:(UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    [super setViewControllers:viewControllers direction:direction animated:animated completion:completion];
    
    _currentScoresTableViewController = (STCSummariesTableViewController *)[viewControllers objectAtIndex:0];
    
    // set date in navbar
    NSDateComponents *currentDateComponents = _currentScoresTableViewController.scoreboardDate;
    NSDate *currentDate = [[NSCalendar currentCalendar] dateFromComponents:currentDateComponents];
    self.navigationItem.title = [_formatter stringFromDate:currentDate];
}

- (void)leftArrowClicked {
    NSDateComponents *dayBefore = [self getComponentsForDayBeforeScoreboard:_currentScoresTableViewController];
    NSArray *backPage = [NSArray arrayWithObjects:[[STCSummariesTableViewController alloc] initWithDateComponents:dayBefore], nil];
    
    [self setViewControllers:backPage
                   direction:UIPageViewControllerNavigationDirectionReverse
                    animated:YES
                  completion:^(BOOL finished) { }];
}

- (void)rightArrowClicked {
    NSDateComponents *dayAfter = [self getComponentsForDayAfterScoreboard:_currentScoresTableViewController];
    NSArray *forwardPage = [NSArray arrayWithObjects:[[STCSummariesTableViewController alloc] initWithDateComponents:dayAfter], nil];
    
    [self setViewControllers:forwardPage
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:^(BOOL finished) { }];
}
@end
