//
//  STCLinescoreInningView.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface STCLinescoreInningLabel : UILabel

- (instancetype)initWithBoldText:(NSString *)text;
- (instancetype)initWithBoldText:(NSString *)text andFontSize:(float)size;
- (instancetype)initWithText:(NSString *)text;

@end
