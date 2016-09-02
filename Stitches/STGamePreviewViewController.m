//
//  STGamePreviewViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGamePreviewViewController.h"
#import "STParserMLB.h"

@interface STGamePreviewViewController () {
@private
    STParserMLB *_previewParser;
    STGameSummary *_game;
}

@end

@implementation STGamePreviewViewController

- (id)initWithGameID:(NSString*)gameID {
    self = [super init];
    
    // download game ID
    _game = [[STGameSummary alloc] init];
    
    _previewParser = [[STParserMLB alloc] init];
    [_previewParser setPreviewDelegate:self];
    [_previewParser parsePreviewWithGameID:gameID];
    
    return self;
}

- (void)parsedGamePreview:(STGameSummary *)preview {
    NSLog(@"Parsed a preview");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
