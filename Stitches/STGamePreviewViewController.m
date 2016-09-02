//
//  STGamePreviewViewController.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STGamePreviewViewController.h"
#import "STGamePreviewParser.h"

@implementation STGamePreviewViewController {
    STGamePreviewParser *_previewParser;
    STGamePreview *_game;
    UILabel *_awayProbablePitcher;
    UILabel *_homeProbablePitcher;
    NSString *_gameID;
}

- (instancetype)initWithGameID:(NSString*)gameID {
    self = [super init];
    if (self) {
        _gameID = gameID;
    }
    return self;
}

- (void)parsedGamePreview:(STGamePreview *)preview {
    NSLog(@"Parsed a preview: %@", preview);
    _homeProbablePitcher.text = [preview homeProbablePitcher];
    _awayProbablePitcher.text = [preview awayProbablePitcher];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:FALSE];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _game = [[STGamePreview alloc] init];
    
    _previewParser = [[STGamePreviewParser alloc] init];
    [_previewParser setDelegate:self];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:TRUE];
    
    // ignore navbar
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *awayPP = [[UILabel alloc] init];
    awayPP.text = @"Away Probable Pitcher";
    awayPP.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:awayPP];
    
    UILabel *homePP = [[UILabel alloc] init];
    homePP.text = @"Home Probable Pitcher";
    homePP.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:homePP];
    
    _homeProbablePitcher = [[UILabel alloc] init];
    _homeProbablePitcher.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:_homeProbablePitcher];
    
    _awayProbablePitcher = [[UILabel alloc] init];
    _awayProbablePitcher.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:_awayProbablePitcher];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(awayPP, homePP, _awayProbablePitcher, _homeProbablePitcher);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[awayPP][_awayProbablePitcher][homePP][_homeProbablePitcher]"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil
                                                                        views:views]];
        
    [_previewParser parsePreviewWithGameID:_gameID];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
