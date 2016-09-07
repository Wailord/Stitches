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

@interface STCFinalizedViewController : UIViewController<STCFinalizedParserDelegate>

- (instancetype)initWithGameID:(NSString*)gameID;

@end
