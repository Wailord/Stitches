//
//  STCFinalViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCFinalizedViewController.h"

@interface STCFinalizedViewController () {
    NSString *_gameID;
}

@end

@implementation STCFinalizedViewController

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
