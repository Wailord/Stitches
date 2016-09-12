//
//  STCSummariesPageViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCScoresPageViewController.h"
#import "STCScoresNavigationController.h"

@interface STCScoresPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate> {
    NSArray *_scoreDays;
    NSDateFormatter *_formatter;
    NSCalendar *_gregorian;
    NSDateComponents *_oneDayBefore;
    NSDateComponents *_oneDayAfter;
}

@end

@implementation STCScoresPageViewController {
    UIPageViewController *_pageViewController;
}

-(instancetype)init {
    self = [super init];
    if(self) {
        _pageViewController =[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                    options:nil];
        _pageViewController.dataSource = self;
        
        // matt says this is bad
        _pageViewController.delegate = self;
    }
    return self;
}

- (void)loadView {
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 30, 30);

    [self addChildViewController:_pageViewController];
    [view addSubview:_pageViewController.view];
    [_pageViewController didMoveToParentViewController:self];
    _pageViewController.view.frame = CGRectMake(0, 0, 30, 30);;
    _pageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    UIBarButtonItem *rightArrow = [[UIBarButtonItem alloc]
                                   initWithTitle:@"\U000025B6\U0000FE0E"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(rightArrowClicked)];
    rightArrow.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightArrow;
    
    UIBarButtonItem *leftArrow = [[UIBarButtonItem alloc]
                                   initWithTitle:@"\U000025C0\U0000FE0E"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(leftArrowClicked)];
    leftArrow.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftArrow;
    
    _formatter = [NSDateFormatter new];
    _formatter.dateFormat = @"EEEE, MMMM d";
    _gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    _oneDayBefore = [NSDateComponents new];
    _oneDayBefore.day = -1;
    
    _oneDayAfter = [NSDateComponents new];
    _oneDayAfter.day = 1;
    
    
    
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
    
    [_pageViewController setViewControllers:@[_currentScoresTableViewController]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:^(BOOL finished) { }];
    self.view = view;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(STCSummariesTableViewController *)viewController {
    NSDateComponents *dayAfter = [self getComponentsForDayAfterScoreboard:viewController];
    
    return [[STCSummariesTableViewController alloc] initWithDateComponents:dayAfter];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(STCSummariesTableViewController *)viewController {
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

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
        [self updateCurrentPageViewController:pendingViewControllers[0]];
}

- (void)updateCurrentPageViewController:(UIViewController *)cont {
    _currentScoresTableViewController = (STCSummariesTableViewController *)cont;
    
    // set date in navbar
    NSDateComponents *currentDateComponents = _currentScoresTableViewController.scoreboardDate;
    NSDate *currentDate = [[NSCalendar currentCalendar] dateFromComponents:currentDateComponents];
    self.navigationItem.title = [_formatter stringFromDate:currentDate];
}

- (void)leftArrowClicked {
    NSDateComponents *dayBefore = [self getComponentsForDayBeforeScoreboard:_currentScoresTableViewController];
    NSArray *backPage = @[[[STCSummariesTableViewController alloc] initWithDateComponents:dayBefore]];
    
    [_pageViewController setViewControllers:backPage
                   direction:UIPageViewControllerNavigationDirectionReverse
                    animated:YES
                  completion:^(BOOL finished) { }];
    
    [self updateCurrentPageViewController:backPage[0]];
}

- (void)rightArrowClicked {
    NSDateComponents *dayAfter = [self getComponentsForDayAfterScoreboard:_currentScoresTableViewController];
    NSArray *forwardPage = @[[[STCSummariesTableViewController alloc] initWithDateComponents:dayAfter]];
    
    [_pageViewController setViewControllers:forwardPage
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                                 completion:^(BOOL finished) { }];
    [self updateCurrentPageViewController:forwardPage[0]];
}
@end
