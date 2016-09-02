//
//  STGameSummaryTableViewController.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParserMLB.h"

@interface STGameSummaryTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource,STParserMLBGameSummaryDelegate>
{
    @private
    STParserMLB *_parser;
}

@property NSMutableArray *gameSummaries;

-(void)parseGames;

@end
