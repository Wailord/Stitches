//
//  ViewController.m
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCScoresPageViewController.h"
#import "STCScoresNavigationController.h"
#import "STCSummariesTableViewController.h"

@implementation STCScoresNavigationController

-(instancetype) init {
    STCScoresPageViewController *svc = [STCScoresPageViewController new];
    return [super initWithRootViewController:svc];
}

@end
