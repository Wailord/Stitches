//
//  STGameSummaryTableViewController.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STGameSummaryTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>

@property NSArray *gameSummaries;

-(void)parseGames;

@end
