//
//  STCFinalViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalViewController.h"

@interface STCFinalViewController () {
    NSString *_gameID;
}

@end

@implementation STCFinalViewController

- (instancetype)initWithGameID:(NSString*)gameID {
    self = [super init];
    if (self) {
        _gameID = gameID;
        self.navigationItem.title = @"Final";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
