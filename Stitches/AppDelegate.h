//
//  AppDelegate.h
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UITabBarController *_tabController;
    UIViewController *_scoreboardViewController;
    UIViewController *_standingsViewController;
    UIViewController *_statisticsViewController;
    UIViewController *_newsViewController;
    UIViewController *_settingsViewController;
    NSArray *_tabbedViewControllers;
}

@property (strong, nonatomic) UIWindow *window;


@end

