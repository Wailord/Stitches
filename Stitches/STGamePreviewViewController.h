//
//  STGamePreviewViewController.h
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParserMLB.h"

@interface STGamePreviewViewController : UIViewController <STParserMLBGamePreviewDelegate>

- (id)initWithGameID:(NSString*)gameID;

@end
