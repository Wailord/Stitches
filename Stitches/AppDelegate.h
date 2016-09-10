//
//  AppDelegate.h
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCScoresNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UITabBarController *_tabController;
    STCScoresNavigationController *_scoresNavigationController;
    UIViewController *_standingsViewController;
    UIViewController *_statisticsViewController;
    UIViewController *_newsViewController;
    UIViewController *_settingsViewController;
    NSArray *_tabbedViewControllers;
}

@property (strong, nonatomic) UIWindow *window;


@end

