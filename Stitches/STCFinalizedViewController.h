//
//  STCFinalViewController.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCFinalizedParser.h"
#import "STCLinescoreView.h"
#import "STCFinalizedTeamView.h"
#import "STCFinalizedView.h"

@interface STCFinalizedViewController : UIViewController

- (instancetype)initWithGameID:(NSString*)gameID;

@end
