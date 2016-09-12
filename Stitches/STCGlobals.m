//
//  Constants.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCGlobals.h"
#import "STCTeam.h"

@implementation STCGlobals

+(NSString *)abbreviationForTeamID:(NSString *)teamID {
    return [[self teamDict][teamID] abbreviation];
}

+(NSString *)fullNameForTeamID:(NSString *)teamID {
    return [[self teamDict][teamID] fullName];
}

+(NSString *)briefNameForTeamID:(NSString *)teamID {
    return [[self teamDict][teamID] briefName];
}

+(NSDictionary*)teamDict {
    static NSDictionary *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst =  @{
                  @"108": [[STCTeam alloc] initWithCode:@"ana"
                                              fileCode:@"ana"
                                          abbreviation:@"LAA"
                                                  name:@"LA Angels"
                                              fullName:@"Los Angeles Angels"
                                             briefName:@"Angels"],
                  @"109":  [[STCTeam alloc] initWithCode:@"ari"
                                               fileCode:@"ari"
                                           abbreviation:@"ARI"
                                                   name:@"Arizona"
                                               fullName:@"Arizona Diamondbacks"
                                              briefName:@"D-backs"
                            ],
                  @"110":  [[STCTeam alloc] initWithCode:@"bal"
                                               fileCode:@"bal"
                                           abbreviation:@"BAL"
                                                   name:@"Balitmore"
                                               fullName:@"Baltimore Orioles"
                                              briefName:@"Orioles"
                            ],
                  @"111":  [[STCTeam alloc] initWithCode:@"bos"
                                               fileCode:@"bos"
                                           abbreviation:@"BOS"
                                                   name:@"Boston"
                                               fullName:@"Boston Red Sox"
                                              briefName:@"Red Sox"
                            ],
                  @"112":  [[STCTeam alloc] initWithCode:@"chn"
                                               fileCode:@"chc"
                                           abbreviation:@"CHC"
                                                   name:@"Chi Cubs"
                                               fullName:@"Chicago Cubs"
                                              briefName:@"Cubs"
                            ],
                  @"113":  [[STCTeam alloc] initWithCode:@"cin"
                                               fileCode:@"cin"
                                           abbreviation:@"CIN"
                                                   name:@"Cincinnati"
                                               fullName:@"Cincinnati Reds"
                                              briefName:@"Reds"
                            ],
                  @"114":  [[STCTeam alloc] initWithCode:@"cle"
                                               fileCode:@"cle"
                                           abbreviation:@"CLE"
                                                   name:@"Cleveland"
                                               fullName:@"Cleveland Indians"
                                              briefName:@"Indians"],
                  @"115":  [[STCTeam alloc] initWithCode:@"col"
                                               fileCode:@"col"
                                           abbreviation:@"COL"
                                                   name:@"Colorado"
                                               fullName:@"Colorado Rockies"
                                              briefName:@"Rockies"
                            ],
                  @"116":  [[STCTeam alloc] initWithCode:@"det"
                                               fileCode:@"det"
                                           abbreviation:@"DET"
                                                   name:@"Detroit"
                                               fullName:@"Detroit Tigers"
                                              briefName:@"Tigers"
                            ],
                  @"117":  [[STCTeam alloc] initWithCode:@"hou"
                                               fileCode:@"hou"
                                           abbreviation:@"HOU"
                                                   name:@"Houston"
                                               fullName:@"Houston Astros"
                                              briefName:@"Astros"
                            ],
                  @"118":  [[STCTeam alloc] initWithCode:@"kca"
                                               fileCode:@"kc"
                                           abbreviation:@"KC"
                                                   name:@"Kansas City"
                                               fullName:@"Kansas City Royals"
                                              briefName:@"Royals"
                            ],
                  @"119":  [[STCTeam alloc] initWithCode:@"lan"
                                               fileCode:@"la"
                                           abbreviation:@"LAD"
                                                   name:@"LA Dodgers"
                                               fullName:@"Los Angeles Dodgers"
                                              briefName:@"Dodgers"
                            ],
                  @"120":  [[STCTeam alloc] initWithCode:@"was"
                                               fileCode:@"was"
                                           abbreviation:@"WSH"
                                                   name:@"Washington"
                                               fullName:@"Washington Nationals"
                                              briefName:@"Nationals"
                            ],
                  @"121":  [[STCTeam alloc] initWithCode:@"nyn"
                                               fileCode:@"nym"
                                           abbreviation:@"NYM"
                                                   name:@"NY Mets"
                                               fullName:@"New York Mets"
                                              briefName:@"Mets"
                            ],
                  @"133":  [[STCTeam alloc] initWithCode:@"oak"
                                               fileCode:@"oak"
                                           abbreviation:@"OAK"
                                                   name:@"Oakland"
                                               fullName:@"Oakland Athletics"
                                              briefName:@"Athletics"],
                  @"134":  [[STCTeam alloc] initWithCode:@"pit"
                                               fileCode:@"pit"
                                           abbreviation:@"PIT"
                                                   name:@"Pittsburgh"
                                               fullName:@"Pittsburgh Pirates"
                                              briefName:@"Pirates"
                            ],
                  @"135":  [[STCTeam alloc] initWithCode:@"sdn"
                                               fileCode:@"sd"
                                           abbreviation:@"SD"
                                                   name:@"San Diego"
                                               fullName:@"San Diego Padres"
                                              briefName:@"Padres"
                            ],
                  @"136":  [[STCTeam alloc] initWithCode:@"sea"
                                               fileCode:@"sea"
                                           abbreviation:@"SEA"
                                                   name:@"Seattle"
                                               fullName:@"Seattle Mariners"
                                              briefName:@"Mariners"
                            ],
                  @"137":  [[STCTeam alloc] initWithCode:@"sfn"
                                               fileCode:@"sf"
                                           abbreviation:@"SF"
                                                   name:@"San Francisco"
                                               fullName:@"San Francisco Giants"
                                              briefName:@"Giants"
                            ],
                  @"138":  [[STCTeam alloc] initWithCode:@"sln"
                                               fileCode:@"stl"
                                           abbreviation:@"STL"
                                                   name:@"St. Louis"
                                               fullName:@"St. Louis Cardinals"
                                              briefName:@"Cardinals"
                            ],
                  @"139":  [[STCTeam alloc] initWithCode:@"tba"
                                               fileCode:@"tb"
                                           abbreviation:@"TB"
                                                   name:@"Tampa Bay"
                                               fullName:@"Tampa Bay Rays"
                                              briefName:@"Rays"
                            ],
                  @"140":  [[STCTeam alloc] initWithCode:@"tex"
                                               fileCode:@"tex"
                                           abbreviation:@"TEX"
                                                   name:@"Texas"
                                               fullName:@"Texas Rangers"
                                              briefName:@"Rangers"
                            ],
                  @"141":  [[STCTeam alloc] initWithCode:@"tor"
                                               fileCode:@"tor"
                                           abbreviation:@"TOR"
                                                   name:@"Toronto"
                                               fullName:@"Toronto Blue Jays"
                                              briefName:@"Blue Jays"
                            ],
                  @"142":  [[STCTeam alloc] initWithCode:@"min"
                                               fileCode:@"min"
                                           abbreviation:@"MIN"
                                                   name:@"Minnesota"
                                               fullName:@"Minnesota Twins"
                                              briefName:@"Twins"
                            ],
                  @"143":  [[STCTeam alloc] initWithCode:@"phi"
                                               fileCode:@"phi"
                                           abbreviation:@"PHI"
                                                   name:@"Philadelphia"
                                               fullName:@"Philadelphia Phillies"
                                              briefName:@"Phillies"
                            ],
                  @"144":  [[STCTeam alloc] initWithCode:@"atl"
                                               fileCode:@"atl"
                                           abbreviation:@"ATL"
                                                   name:@"Atlanta"
                                               fullName:@"Atlanta Braves"
                                              briefName:@"Braves"
                            ],
                  @"145":  [[STCTeam alloc] initWithCode:@"cha"
                                               fileCode:@"cws"
                                           abbreviation:@"CWS"
                                                   name:@"Chi White Sox"
                                               fullName:@"Chicago White Sox"
                                              briefName:@"White Sox"
                            ],
                  @"146":  [[STCTeam alloc] initWithCode:@"mia"
                                               fileCode:@"mia"
                                           abbreviation:@"MIA"
                                                   name:@"Miami"
                                               fullName:@"Miami Marlins"
                                              briefName:@"Marlins"
                            ],
                  @"147":  [[STCTeam alloc] initWithCode:@"nya"
                                               fileCode:@"nyy"
                                           abbreviation:@"NYY"
                                                   name:@"NY Yankees"
                                               fullName:@"New York Yankees"
                                              briefName:@"Yankees"
                            ],
                  @"158":  [[STCTeam alloc] initWithCode:@"mil"
                                               fileCode:@"mil"
                                           abbreviation:@"MIL"
                                                   name:@"Milwaukee"
                                               fullName:@"Milwaukee Brewers"
                                              briefName:@"Brewers"
                            ],
                  @"159":  [[STCTeam alloc] initWithCode:@"aas"
                                               fileCode:@"al"
                                           abbreviation:@"AL"
                                                   name:@"AL All-Stars"
                                               fullName:@"American League All-Stars"
                                              briefName:@"AL All-Stars"
                            ],
                  @"160":  [[STCTeam alloc] initWithCode:@"nas"
                                               fileCode:@"nl"
                                           abbreviation:@"NL"
                                                   name:@"NL All-Stars"
                                               fullName:@"National League All-Stars"
                                              briefName:@"NL All-Stars"
                            ]
                  };
    });
    return inst;
}

@end
