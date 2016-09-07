//
//  STCLinescoreInningView.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCLinescoreInningLabel.h"

@implementation STCLinescoreInningLabel

- (instancetype)init {
    self = [super init];
    if(self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0f;
        self.text = @"-";
    }
    
    return self;
}

@end
