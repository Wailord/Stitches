//
//  ViewController.h
//  Stitches
//
//  Created by Ryan Fox on 8/31/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCSummariesTableViewController.h"

@interface STCScoresNavigationController : UINavigationController

@property NSDateComponents *scoreboardDate;

- (instancetype)initWithYear:(NSInteger)year andMonth:(NSInteger)month andDate:(NSInteger)date;

@end

