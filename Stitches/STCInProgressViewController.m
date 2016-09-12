//
//  STCInProgressViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/12/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCInProgressViewController.h"
#import "STCInProgressGameParser.h"

@interface STCInProgressViewController ()<STCInProgressParserDelegate>
@end

@implementation STCInProgressViewController

- (instancetype)initWithGameID:(NSString*)gameID {
    self = [super init];
    if(self) {
        NSLog(@"TODO: in-progress view controller");
    }
    
    return self;
}

- (void)parsedInProgressGame:(STCInProgressGame *)preview {
    NSLog(@"TODO: update labels with a parsed in-progress game");
}

-(void)updatedInProgressGame:(STCInProgressGame *)updatedGame {
    NSLog(@"TODO: update labels with an updated in-progress game");
}

@end
