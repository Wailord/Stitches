//
//  Constants.m
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STConstants.h"

@implementation STConstants

+(NSDictionary*)teamDict {
    static NSDictionary *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst =  @{
                  @"108": [[STMLBTeam alloc] initWithCode:@"ana"
                                              andFileCode:@"ana"
                                          andAbbreviation:@"LAA"
                                                  andName:@"LA Angels"
                                              andFullName:@"Los Angeles Angels"
                                             andBriefName:@"Angels"],
                  @"109":  [[STMLBTeam alloc] initWithCode:@"ari"
                                               andFileCode:@"ari"
                                           andAbbreviation:@"ARI"
                                                   andName:@"Arizona"
                                               andFullName:@"Arizona Diamondbacks"
                                              andBriefName:@"D-backs"
                            ],
                  @"110":  [[STMLBTeam alloc] initWithCode:@"bal"
                                               andFileCode:@"bal"
                                           andAbbreviation:@"BAL"
                                                   andName:@"Balitmore"
                                               andFullName:@"Baltimore Orioles"
                                              andBriefName:@"Orioles"
                            ],
                  @"111":  [[STMLBTeam alloc] initWithCode:@"bos"
                                               andFileCode:@"bos"
                                           andAbbreviation:@"BOS"
                                                   andName:@"Boston"
                                               andFullName:@"Boston Red Sox"
                                              andBriefName:@"Red Sox"
                            ],
                  @"112":  [[STMLBTeam alloc] initWithCode:@"chn"
                                               andFileCode:@"chc"
                                           andAbbreviation:@"CHC"
                                                   andName:@"Chi Cubs"
                                               andFullName:@"Chicago Cubs"
                                              andBriefName:@"Cubs"
                            ],
                  @"113":  [[STMLBTeam alloc] initWithCode:@"cin"
                                               andFileCode:@"cin"
                                           andAbbreviation:@"CIN"
                                                   andName:@"Cincinnati"
                                               andFullName:@"Cincinnati Reds"
                                              andBriefName:@"Reds"
                            ],
                  @"114":  [[STMLBTeam alloc] initWithCode:@"cle"
                                               andFileCode:@"cle"
                                           andAbbreviation:@"CLE"
                                                   andName:@"Cleveland"
                                               andFullName:@"Cleveland Indians"
                                              andBriefName:@"Indians"],
                  @"115":  [[STMLBTeam alloc] initWithCode:@"col"
                                               andFileCode:@"col"
                                           andAbbreviation:@"COL"
                                                   andName:@"Colorado"
                                               andFullName:@"Colorado Rockies"
                                              andBriefName:@"Rockies"
                            ],
                  @"116":  [[STMLBTeam alloc] initWithCode:@"det"
                                               andFileCode:@"det"
                                           andAbbreviation:@"DET"
                                                   andName:@"Detroit"
                                               andFullName:@"Detroit Tigers"
                                              andBriefName:@"Tigers"
                            ],
                  @"117":  [[STMLBTeam alloc] initWithCode:@"hou"
                                               andFileCode:@"hou"
                                           andAbbreviation:@"HOU"
                                                   andName:@"Houston"
                                               andFullName:@"Houston Astros"
                                              andBriefName:@"Astros"
                            ],
                  @"118":  [[STMLBTeam alloc] initWithCode:@"kca"
                                               andFileCode:@"kc"
                                           andAbbreviation:@"KC"
                                                   andName:@"Kansas City"
                                               andFullName:@"Kansas City Royals"
                                              andBriefName:@"Royals"
                            ],
                  @"119":  [[STMLBTeam alloc] initWithCode:@"lan"
                                               andFileCode:@"la"
                                           andAbbreviation:@"LAD"
                                                   andName:@"LA Dodgers"
                                               andFullName:@"Los Angeles Dodgers"
                                              andBriefName:@"Dodgers"
                            ],
                  @"120":  [[STMLBTeam alloc] initWithCode:@"was"
                                               andFileCode:@"was"
                                           andAbbreviation:@"WSH"
                                                   andName:@"Washington"
                                               andFullName:@"Washington Nationals"
                                              andBriefName:@"Nationals"
                            ],
                  @"121":  [[STMLBTeam alloc] initWithCode:@"nyn"
                                               andFileCode:@"nym"
                                           andAbbreviation:@"NYM"
                                                   andName:@"NY Mets"
                                               andFullName:@"New York Mets"
                                              andBriefName:@"Mets"
                            ],
                  @"133":  [[STMLBTeam alloc] initWithCode:@"oak"
                                               andFileCode:@"oak"
                                           andAbbreviation:@"OAK"
                                                   andName:@"Oakland"
                                               andFullName:@"Oakland Athletics"
                                              andBriefName:@"Athletics"],
                  @"134":  [[STMLBTeam alloc] initWithCode:@"pit"
                                               andFileCode:@"pit"
                                           andAbbreviation:@"PIT"
                                                   andName:@"Pittsburgh"
                                               andFullName:@"Pittsburgh Pirates"
                                              andBriefName:@"Pirates"
                            ],
                  @"135":  [[STMLBTeam alloc] initWithCode:@"sdn"
                                               andFileCode:@"sd"
                                           andAbbreviation:@"SD"
                                                   andName:@"San Diego"
                                               andFullName:@"San Diego Padres"
                                              andBriefName:@"Padres"
                            ],
                  @"136":  [[STMLBTeam alloc] initWithCode:@"sea"
                                               andFileCode:@"sea"
                                           andAbbreviation:@"SEA"
                                                   andName:@"Seattle"
                                               andFullName:@"Seattle Mariners"
                                              andBriefName:@"Mariners"
                            ],
                  @"137":  [[STMLBTeam alloc] initWithCode:@"sfn"
                                               andFileCode:@"sf"
                                           andAbbreviation:@"SF"
                                                   andName:@"San Francisco"
                                               andFullName:@"San Francisco Giants"
                                              andBriefName:@"Giants"
                            ],
                  @"138":  [[STMLBTeam alloc] initWithCode:@"sln"
                                               andFileCode:@"stl"
                                           andAbbreviation:@"STL"
                                                   andName:@"St. Louis"
                                               andFullName:@"St. Louis Cardinals"
                                              andBriefName:@"Cardinals"
                            ],
                  @"139":  [[STMLBTeam alloc] initWithCode:@"tba"
                                               andFileCode:@"tb"
                                           andAbbreviation:@"TB"
                                                   andName:@"Tampa Bay"
                                               andFullName:@"Tampa Bay Rays"
                                              andBriefName:@"Rays"
                            ],
                  @"140":  [[STMLBTeam alloc] initWithCode:@"tex"
                                               andFileCode:@"tex"
                                           andAbbreviation:@"TEX"
                                                   andName:@"Texas"
                                               andFullName:@"Texas Rangers"
                                              andBriefName:@"Rangers"
                            ],
                  @"141":  [[STMLBTeam alloc] initWithCode:@"tor"
                                               andFileCode:@"tor"
                                           andAbbreviation:@"TOR"
                                                   andName:@"Toronto"
                                               andFullName:@"Toronto Blue Jays"
                                              andBriefName:@"Blue Jays"
                            ],
                  @"142":  [[STMLBTeam alloc] initWithCode:@"min"
                                               andFileCode:@"min"
                                           andAbbreviation:@"MIN"
                                                   andName:@"Minnesota"
                                               andFullName:@"Minnesota Twins"
                                              andBriefName:@"Twins"
                            ],
                  @"143":  [[STMLBTeam alloc] initWithCode:@"phi"
                                               andFileCode:@"phi"
                                           andAbbreviation:@"PHI"
                                                   andName:@"Philadelphia"
                                               andFullName:@"Philadelphia Phillies"
                                              andBriefName:@"Phillies"
                            ],
                  @"144":  [[STMLBTeam alloc] initWithCode:@"atl"
                                               andFileCode:@"atl"
                                           andAbbreviation:@"ATL"
                                                   andName:@"Atlanta"
                                               andFullName:@"Atlanta Braves"
                                              andBriefName:@"Braves"
                            ],
                  @"145":  [[STMLBTeam alloc] initWithCode:@"cha"
                                               andFileCode:@"cws"
                                           andAbbreviation:@"CWS"
                                                   andName:@"Chi White Sox"
                                               andFullName:@"Chicago White Sox"
                                              andBriefName:@"White Sox"
                            ],
                  @"146":  [[STMLBTeam alloc] initWithCode:@"mia"
                                               andFileCode:@"mia"
                                           andAbbreviation:@"MIA"
                                                   andName:@"Miami"
                                               andFullName:@"Miami Marlins"
                                              andBriefName:@"Marlins"
                            ],
                  @"147":  [[STMLBTeam alloc] initWithCode:@"nya"
                                               andFileCode:@"nyy"
                                           andAbbreviation:@"NYY"
                                                   andName:@"NY Yankees"
                                               andFullName:@"New York Yankees"
                                              andBriefName:@"Yankees"
                            ],
                  @"158":  [[STMLBTeam alloc] initWithCode:@"mil"
                                               andFileCode:@"mil"
                                           andAbbreviation:@"MIL"
                                                   andName:@"Milwaukee"
                                               andFullName:@"Milwaukee Brewers"
                                              andBriefName:@"Brewers"
                            ],
                  @"159":  [[STMLBTeam alloc] initWithCode:@"aas"
                                               andFileCode:@"al"
                                           andAbbreviation:@"AL"
                                                   andName:@"AL All-Stars"
                                               andFullName:@"American League All-Stars"
                                              andBriefName:@"AL All-Stars"
                            ],
                  @"160":  [[STMLBTeam alloc] initWithCode:@"nas"
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
