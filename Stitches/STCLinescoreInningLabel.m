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

- (instancetype)initWithBoldText:(NSString *)text {
    self = [super init];
    if(self) {
        self.text = text;
        self.font = [UIFont boldSystemFontOfSize:18.0f];self.textAlignment = NSTextAlignmentCenter;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
    
    return self;
}

- (instancetype)initWithBoldText:(NSString *)text andFontSize:(float)size {
    self = [super init];
    if(self) {
        self.text = text;
        self.font = [UIFont boldSystemFontOfSize:size];
        self.textAlignment = NSTextAlignmentCenter;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }

    return self;
}

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if(self) {
        self.text = text;self.textAlignment = NSTextAlignmentCenter;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
    
    return self;
}

@end
