//
//  STCSummariesPageViewController.h
//  Stitches
//
//  Created by Ryan Fox on 9/7/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCScoresNavigationController.h"

@interface STCScoresPageViewController : UIPageViewController<UIPageViewControllerDataSource>

@property STCScoresNavigationController *scoresNavigationController;

@end
