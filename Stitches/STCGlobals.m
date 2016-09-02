//
//  Constants.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCGlobals.h"

@implementation STCGlobals

+(NSDictionary*)teamDict {
    static NSDictionary *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst =  @{
                  @"108": [[STCTeam alloc] initWithCode:@"ana"
                                              andFileCode:@"ana"
                                          andAbbreviation:@"LAA"
                                                  andName:@"LA Angels"
                                              andFullName:@"Los Angeles Angels"
                                             andBriefName:@"Angels"],
                  @"109":  [[STCTeam alloc] initWithCode:@"ari"
                                               andFileCode:@"ari"
                                           andAbbreviation:@"ARI"
                                                   andName:@"Arizona"
                                               andFullName:@"Arizona Diamondbacks"
                                              andBriefName:@"D-backs"
                            ],
                  @"110":  [[STCTeam alloc] initWithCode:@"bal"
                                               andFileCode:@"bal"
                                           andAbbreviation:@"BAL"
                                                   andName:@"Balitmore"
                                               andFullName:@"Baltimore Orioles"
                                              andBriefName:@"Orioles"
                            ],
                  @"111":  [[STCTeam alloc] initWithCode:@"bos"
                                               andFileCode:@"bos"
                                           andAbbreviation:@"BOS"
                                                   andName:@"Boston"
                                               andFullName:@"Boston Red Sox"
                                              andBriefName:@"Red Sox"
                            ],
                  @"112":  [[STCTeam alloc] initWithCode:@"chn"
                                               andFileCode:@"chc"
                                           andAbbreviation:@"CHC"
                                                   andName:@"Chi Cubs"
                                               andFullName:@"Chicago Cubs"
                                              andBriefName:@"Cubs"
                            ],
                  @"113":  [[STCTeam alloc] initWithCode:@"cin"
                                               andFileCode:@"cin"
                                           andAbbreviation:@"CIN"
                                                   andName:@"Cincinnati"
                                               andFullName:@"Cincinnati Reds"
                                              andBriefName:@"Reds"
                            ],
                  @"114":  [[STCTeam alloc] initWithCode:@"cle"
                                               andFileCode:@"cle"
                                           andAbbreviation:@"CLE"
                                                   andName:@"Cleveland"
                                               andFullName:@"Cleveland Indians"
                                              andBriefName:@"Indians"],
                  @"115":  [[STCTeam alloc] initWithCode:@"col"
                                               andFileCode:@"col"
                                           andAbbreviation:@"COL"
                                                   andName:@"Colorado"
                                               andFullName:@"Colorado Rockies"
                                              andBriefName:@"Rockies"
                            ],
                  @"116":  [[STCTeam alloc] initWithCode:@"det"
                                               andFileCode:@"det"
                                           andAbbreviation:@"DET"
                                                   andName:@"Detroit"
                                               andFullName:@"Detroit Tigers"
                                              andBriefName:@"Tigers"
                            ],
                  @"117":  [[STCTeam alloc] initWithCode:@"hou"
                                               andFileCode:@"hou"
                                           andAbbreviation:@"HOU"
                                                   andName:@"Houston"
                                               andFullName:@"Houston Astros"
                                              andBriefName:@"Astros"
                            ],
                  @"118":  [[STCTeam alloc] initWithCode:@"kca"
                                               andFileCode:@"kc"
                                           andAbbreviation:@"KC"
                                                   andName:@"Kansas City"
                                               andFullName:@"Kansas City Royals"
                                              andBriefName:@"Royals"
                            ],
                  @"119":  [[STCTeam alloc] initWithCode:@"lan"
                                               andFileCode:@"la"
                                           andAbbreviation:@"LAD"
                                                   andName:@"LA Dodgers"
                                               andFullName:@"Los Angeles Dodgers"
                                              andBriefName:@"Dodgers"
                            ],
                  @"120":  [[STCTeam alloc] initWithCode:@"was"
                                               andFileCode:@"was"
                                           andAbbreviation:@"WSH"
                                                   andName:@"Washington"
                                               andFullName:@"Washington Nationals"
                                              andBriefName:@"Nationals"
                            ],
                  @"121":  [[STCTeam alloc] initWithCode:@"nyn"
                                               andFileCode:@"nym"
                                           andAbbreviation:@"NYM"
                                                   andName:@"NY Mets"
                                               andFullName:@"New York Mets"
                                              andBriefName:@"Mets"
                            ],
                  @"133":  [[STCTeam alloc] initWithCode:@"oak"
                                               andFileCode:@"oak"
                                           andAbbreviation:@"OAK"
                                                   andName:@"Oakland"
                                               andFullName:@"Oakland Athletics"
                                              andBriefName:@"Athletics"],
                  @"134":  [[STCTeam alloc] initWithCode:@"pit"
                                               andFileCode:@"pit"
                                           andAbbreviation:@"PIT"
                                                   andName:@"Pittsburgh"
                                               andFullName:@"Pittsburgh Pirates"
                                              andBriefName:@"Pirates"
                            ],
                  @"135":  [[STCTeam alloc] initWithCode:@"sdn"
                                               andFileCode:@"sd"
                                           andAbbreviation:@"SD"
                                                   andName:@"San Diego"
                                               andFullName:@"San Diego Padres"
                                              andBriefName:@"Padres"
                            ],
                  @"136":  [[STCTeam alloc] initWithCode:@"sea"
                                               andFileCode:@"sea"
                                           andAbbreviation:@"SEA"
                                                   andName:@"Seattle"
                                               andFullName:@"Seattle Mariners"
                                              andBriefName:@"Mariners"
                            ],
                  @"137":  [[STCTeam alloc] initWithCode:@"sfn"
                                               andFileCode:@"sf"
                                           andAbbreviation:@"SF"
                                                   andName:@"San Francisco"
                                               andFullName:@"San Francisco Giants"
                                              andBriefName:@"Giants"
                            ],
                  @"138":  [[STCTeam alloc] initWithCode:@"sln"
                                               andFileCode:@"stl"
                                           andAbbreviation:@"STL"
                                                   andName:@"St. Louis"
                                               andFullName:@"St. Louis Cardinals"
                                              andBriefName:@"Cardinals"
                            ],
                  @"139":  [[STCTeam alloc] initWithCode:@"tba"
                                               andFileCode:@"tb"
                                           andAbbreviation:@"TB"
                                                   andName:@"Tampa Bay"
                                               andFullName:@"Tampa Bay Rays"
                                              andBriefName:@"Rays"
                            ],
                  @"140":  [[STCTeam alloc] initWithCode:@"tex"
                                               andFileCode:@"tex"
                                           andAbbreviation:@"TEX"
                                                   andName:@"Texas"
                                               andFullName:@"Texas Rangers"
                                              andBriefName:@"Rangers"
                            ],
                  @"141":  [[STCTeam alloc] initWithCode:@"tor"
                                               andFileCode:@"tor"
                                           andAbbreviation:@"TOR"
                                                   andName:@"Toronto"
                                               andFullName:@"Toronto Blue Jays"
                                              andBriefName:@"Blue Jays"
                            ],
                  @"142":  [[STCTeam alloc] initWithCode:@"min"
                                               andFileCode:@"min"
                                           andAbbreviation:@"MIN"
                                                   andName:@"Minnesota"
                                               andFullName:@"Minnesota Twins"
                                              andBriefName:@"Twins"
                            ],
                  @"143":  [[STCTeam alloc] initWithCode:@"phi"
                                               andFileCode:@"phi"
                                           andAbbreviation:@"PHI"
                                                   andName:@"Philadelphia"
                                               andFullName:@"Philadelphia Phillies"
                                              andBriefName:@"Phillies"
                            ],
                  @"144":  [[STCTeam alloc] initWithCode:@"atl"
                                               andFileCode:@"atl"
                                           andAbbreviation:@"ATL"
                                                   andName:@"Atlanta"
                                               andFullName:@"Atlanta Braves"
                                              andBriefName:@"Braves"
                            ],
                  @"145":  [[STCTeam alloc] initWithCode:@"cha"
                                               andFileCode:@"cws"
                                           andAbbreviation:@"CWS"
                                                   andName:@"Chi White Sox"
                                               andFullName:@"Chicago White Sox"
                                              andBriefName:@"White Sox"
                            ],
                  @"146":  [[STCTeam alloc] initWithCode:@"mia"
                                               andFileCode:@"mia"
                                           andAbbreviation:@"MIA"
                                                   andName:@"Miami"
                                               andFullName:@"Miami Marlins"
                                              andBriefName:@"Marlins"
                            ],
                  @"147":  [[STCTeam alloc] initWithCode:@"nya"
                                               andFileCode:@"nyy"
                                           andAbbreviation:@"NYY"
                                                   andName:@"NY Yankees"
                                               andFullName:@"New York Yankees"
                                              andBriefName:@"Yankees"
                            ],
                  @"158":  [[STCTeam alloc] initWithCode:@"mil"
                                               andFileCode:@"mil"
                                           andAbbreviation:@"MIL"
                                                   andName:@"Milwaukee"
                                               andFullName:@"Milwaukee Brewers"
                                              andBriefName:@"Brewers"
                            ],
                  @"159":  [[STCTeam alloc] initWithCode:@"aas"
                                               andFileCode:@"al"
                                           andAbbreviation:@"AL"
                                                   andName:@"AL All-Stars"
                                               andFullName:@"American League All-Stars"
                                              andBriefName:@"AL All-Stars"
                            ],
                  @"160":  [[STCTeam alloc] initWithCode:@"nas"
                                               andFileCode:@"nl"
                                           andAbbreviation:@"NL"
                                                   andName:@"NL All-Stars"
                                               andFullName:@"National League All-Stars"
                                              andBriefName:@"NL All-Stars"
                            ]
                  };
    });
    return inst;
}

@end
