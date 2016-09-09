//
//  STGameSummaryTableViewController.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCSummaryParser.h"

@interface STCSummariesTableViewController : UITableViewController <STCSummaryParserDelegate>

@property NSMutableArray *gameSummaries;
@property NSDateComponents *scoreboardDate;

-(void)parseGames;
-(instancetype)initWithDateComponents:(NSDateComponents *)components;
@end
