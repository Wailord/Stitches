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
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // show the window
    [self.window makeKeyAndVisible];
    
    _tabController = [[UITabBarController alloc] init];

    _scoreboardPageViewController = [[STCScoresPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                         options:nil];
    
    // the standings view, which will show the current MLB standings
    _standingsViewController = [[UIViewController alloc] init];
    _standingsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Standings"
                                                                        image:[UIImage imageNamed:@"standings.png"]
                                                                          tag:0];
    
    // the statistics view, which will show various leaderboards
    _statisticsViewController = [[UIViewController alloc] init];
    _statisticsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Stats"
                                                                        image:[UIImage imageNamed:@"statistics.png"]
                                                                          tag:0];
    
    // the news view, which will show news from around the league
    _newsViewController = [[UIViewController alloc] init];
    _newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News"
                                                                        image:[UIImage imageNamed:@"news.png"]
                                                                          tag:0];
                                      
    // the settings view, which will let users modify various TBD app setitngs
    _settingsViewController = [[UIViewController alloc] init];
    _settingsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings"
                                                                        image:[UIImage imageNamed:@"settings.png"]
                                                                          tag:0];
                                      
    // the collection of viewcontrollers housed within the tabs
    _tabbedViewControllers = [[NSArray alloc] initWithObjects:
                              _scoreboardPageViewController,
                              _standingsViewController,
                              _statisticsViewController,
                              _newsViewController,
                              _settingsViewController,
                              nil];
    
    // let the tab controller know what view controllers to house
    _tabController.viewControllers = _tabbedViewControllers;
    
    // create a view controller for the window to default to
    self.window.rootViewController= _tabController;
    _tabController.selectedIndex = 0;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
