//
//  STCFinalizedGame.h
//  Stitches
//
//  Created by Ryan Fox on 9/6/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCFinalizedTeam.h"
#import "STCSavePitcher.h"
#import "STCVenue.h"

@interface STCFinalizedGame : NSObject

@property STCFinalizedTeam *awayTeam;
@property STCFinalizedTeam *homeTeam;
@property STCVenue *venue;
@property STCPitcher *winningPitcher;
@property STCPitcher *losingPitcher;
@property STCSavePitcher *savingPitcher;
@property NSMutableArray *innings;
@property bool awayTeamWon;

@end
