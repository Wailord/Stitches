//
//  STCSummariesPageViewController.h
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCScoresNavigationController.h"
#import "STCSummariesTableViewController.h"

@interface STCScoresPageViewController : UIPageViewController<UIPageViewControllerDataSource>

@property STCSummariesTableViewController *scoresTableViewController;

@end
