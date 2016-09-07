//
//  AppDelegate.h
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCScoresNavigationController.h"
#import "STCScoresPageViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    // tabs
    UITabBarController *_tabController;
    STCScoresPageViewController *_scoreboardPageViewController;
    UIViewController *_standingsViewController;
    UIViewController *_statisticsViewController;
    UIViewController *_newsViewController;
    UIViewController *_settingsViewController;
    NSArray *_tabbedViewControllers;
}

@property (strong, nonatomic) UIWindow *window;


@end

