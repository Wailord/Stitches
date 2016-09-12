//
//  AppDelegate.m
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // set up our initial window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // show the window
    [self.window makeKeyAndVisible];
    
    _tabController = [UITabBarController new];

    _scoresNavigationController = [STCScoresNavigationController new];
    // the standings view, which will show the current MLB standings
    _standingsViewController = [UIViewController new];
    _standingsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Standings"
                                                                        image:[UIImage imageNamed:@"standings.png"]
                                                                          tag:0];
    
    // the statistics view, which will show various leaderboards
    _statisticsViewController = [UIViewController new];
    _statisticsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Stats"
                                                                        image:[UIImage imageNamed:@"statistics.png"]
                                                                          tag:0];
    
    // the news view, which will show news from around the league
    _newsViewController = [UIViewController new];
    _newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News"
                                                                        image:[UIImage imageNamed:@"news.png"]
                                                                          tag:0];
                                      
    // the settings view, which will let users modify various TBD app setitngs
    _settingsViewController = [UIViewController new];
    _settingsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings"
                                                                        image:[UIImage imageNamed:@"settings.png"]
                                                                          tag:0];
                                      
    // the collection of viewcontrollers housed within the tabs
    _tabbedViewControllers = @[
                              _scoresNavigationController,
                              _standingsViewController,
                              _statisticsViewController,
                              _newsViewController,
                              _settingsViewController
                              ];
    
    // let the tab controller know what view controllers to house
    _tabController.viewControllers = _tabbedViewControllers;
    
    // create a view controller for the window to default to
    self.window.rootViewController= _tabController;
    _tabController.selectedIndex = 0;
    
    return YES;
}

@end
