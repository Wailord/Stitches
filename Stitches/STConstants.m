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
        inst = @{
                 @"108": @{
                         @"code":@"ana",
                         @"file_code":@"ana",
                         @"abbrev":@"LAA",
                         @"name":@"LA Angels",
                         @"full_name":@"Los Angeles Angels",
                         @"brief_name":@"Angels",
                         },
                 @"109": @{
                         @"code":@"ari",
                         @"file_code":@"ari",
                         @"abbrev":@"ARI",
                         @"name":@"Arizona",
                         @"full_name":@"Arizona Diamondbacks",
                         @"brief_name":@"D-backs",
                         },
                 @"110": @{
                         @"code":@"bal",
                         @"file_code":@"bal",
                         @"abbrev":@"BAL",
                         @"name":@"Balitmore",
                         @"full_name":@"Baltimore Orioles",
                         @"brief_name":@"Orioles",
                         },
                 @"111": @{
                         @"code":@"bos",
                         @"file_code":@"bos",
                         @"abbrev":@"BOS",
                         @"name":@"Boston",
                         @"full_name":@"Boston Red Sox",
                         @"brief_name":@"Red Sox",
                         },
                 @"112": @{
                         @"code":@"chn",
                         @"file_code":@"chc",
                         @"abbrev":@"CHC",
                         @"name":@"Chi Cubs",
                         @"full_name":@"Chicago Cubs",
                         @"brief_name":@"Cubs",
                         },
                 @"113": @{
                         @"code":@"cin",
                         @"file_code":@"cin",
                         @"abbrev":@"CIN",
                         @"name":@"Cincinnati",
                         @"full_name":@"Cincinnati Reds",
                         @"brief_name":@"Reds",
                         },
                 @"114": @{
                         @"code":@"cle",
                         @"file_code":@"cle",
                         @"abbrev":@"CLE",
                         @"name":@"Cleveland",
                         @"full_name":@"Cleveland Indians",
                         @"brief_name":@"Indians",
                         },
                 @"115": @{
                         @"code":@"col",
                         @"file_code":@"col",
                         @"abbrev":@"COL",
                         @"name":@"Colorado",
                         @"full_name":@"Colorado Rockies",
                         @"brief_name":@"Rockies",
                         },
                 @"116": @{
                         @"code":@"det",
                         @"file_code":@"det",
                         @"abbrev":@"DET",
                         @"name":@"Detroit",
                         @"full_name":@"Detroit Tigers",
                         @"brief_name":@"Tigers",
                         },
                 @"117": @{
                         @"code":@"hou",
                         @"file_code":@"hou",
                         @"abbrev":@"HOU",
                         @"name":@"Houston",
                         @"full_name":@"Houston Astros",
                         @"brief_name":@"Astros",
                         },
                 @"118": @{
                         @"code":@"kca",
                         @"file_code":@"kc",
                         @"abbrev":@"KC",
                         @"name":@"Kansas City",
                         @"full_name":@"Kansas City Royals",
                         @"brief_name":@"Royals",
                         },
                 @"119": @{
                         @"code":@"lan",
                         @"file_code":@"la",
                         @"abbrev":@"LAD",
                         @"name":@"LA Dodgers",
                         @"full_name":@"Los Angeles Dodgers",
                         @"brief_name":@"Dodgers",
                         },
                 @"120": @{
                         @"code":@"was",
                         @"file_code":@"was",
                         @"abbrev":@"WSH",
                         @"name":@"Washington",
                         @"full_name":@"Washington Nationals",
                         @"brief_name":@"Nationals",
                         },
                 @"121": @{
                         @"code":@"nyn",
                         @"file_code":@"nym",
                         @"abbrev":@"NYM",
                         @"name":@"NY Mets",
                         @"full_name":@"New York Mets",
                         @"brief_name":@"Mets",
                         },
                 @"133": @{
                         @"code":@"oak",
                         @"file_code":@"oak",
                         @"abbrev":@"OAK",
                         @"name":@"Oakland",
                         @"full_name":@"Oakland Athletics",
                         @"brief_name":@"Athletics",
                         },
                 @"134": @{
                         @"code":@"pit",
                         @"file_code":@"pit",
                         @"abbrev":@"PIT",
                         @"name":@"Pittsburgh",
                         @"full_name":@"Pittsburgh Pirates",
                         @"brief_name":@"Pirates",
                         },
                 @"135": @{
                         @"code":@"sdn",
                         @"file_code":@"sd",
                         @"abbrev":@"SD",
                         @"name":@"San Diego",
                         @"full_name":@"San Diego Padres",
                         @"brief_name":@"Padres",
                         },
                 @"136": @{
                         @"code":@"sea",
                         @"file_code":@"sea",
                         @"abbrev":@"SEA",
                         @"name":@"Seattle",
                         @"full_name":@"Seattle Mariners",
                         @"brief_name":@"Mariners",
                         },
                 @"137": @{
                         @"code":@"sfn",
                         @"file_code":@"sf",
                         @"abbrev":@"SF",
                         @"name":@"San Francisco",
                         @"full_name":@"San Francisco Giants",
                         @"brief_name":@"Giants",
                         },
                 @"138": @{
                         @"code":@"sln",
                         @"file_code":@"stl",
                         @"abbrev":@"STL",
                         @"name":@"St. Louis",
                         @"full_name":@"St. Louis Cardinals",
                         @"brief_name":@"Cardinals",
                         },
                 @"139": @{
                         @"code":@"tba",
                         @"file_code":@"tb",
                         @"abbrev":@"TB",
                         @"name":@"Tampa Bay",
                         @"full_name":@"Tampa Bay Rays",
                         @"brief_name":@"Rays",
                         },
                 @"140": @{
                         @"code":@"tex",
                         @"file_code":@"tex",
                         @"abbrev":@"TEX",
                         @"name":@"Texas",
                         @"full_name":@"Texas Rangers",
                         @"brief_name":@"Rangers",
                         },
                 @"141": @{
                         @"code":@"tor",
                         @"file_code":@"tor",
                         @"abbrev":@"TOR",
                         @"name":@"Toronto",
                         @"full_name":@"Toronto Blue Jays",
                         @"brief_name":@"Blue Jays",
                         },
                 @"142": @{
                         @"code":@"min",
                         @"file_code":@"min",
                         @"abbrev":@"MIN",
                         @"name":@"Minnesota",
                         @"full_name":@"Minnesota Twins",
                         @"brief_name":@"Twins",
                         },
                 @"143": @{
                         @"code":@"phi",
                         @"file_code":@"phi",
                         @"abbrev":@"PHI",
                         @"name":@"Philadelphia",
                         @"full_name":@"Philadelphia Phillies",
                         @"brief_name":@"Phillies",
                         },
                 @"144": @{
                         @"code":@"atl",
                         @"file_code":@"atl",
                         @"abbrev":@"ATL",
                         @"name":@"Atlanta",
                         @"full_name":@"Atlanta Braves",
                         @"brief_name":@"Braves",
                         },
                 @"145": @{
                         @"code":@"cha",
                         @"file_code":@"cws",
                         @"abbrev":@"CWS",
                         @"name":@"Chi White Sox",
                         @"full_name":@"Chicago White Sox",
                         @"brief_name":@"White Sox",
                         },
                 @"146": @{
                         @"code":@"mia",
                         @"file_code":@"mia",
                         @"abbrev":@"MIA",
                         @"name":@"Miami",
                         @"full_name":@"Miami Marlins",
                         @"brief_name":@"Marlins",
                         },
                 @"147": @{
                         @"code":@"nya",
                         @"file_code":@"nyy",
                         @"abbrev":@"NYY",
                         @"name":@"NY Yankees",
                         @"full_name":@"New York Yankees",
                         @"brief_name":@"Yankees",
                         },
                 @"158": @{
                         @"code":@"mil",
                         @"file_code":@"mil",
                         @"abbrev":@"MIL",
                         @"name":@"Milwaukee",
                         @"full_name":@"Milwaukee Brewers",
                         @"brief_name":@"Brewers",
                         },
                 @"159": @{
                         @"code":@"aas",
                         @"file_code":@"al",
                         @"abbrev":@"AL",
                         @"name":@"AL All-Stars",
                         @"full_name":@"American League All-Stars",
                         @"brief_name":@"AL All-Stars",
                         },
                 @"160": @{
                         @"code":@"nas",
                         @"file_code":@"nl",
                         @"abbrev":@"NL",
                         @"name":@"NL All-Stars",
                         @"full_name":@"National League All-Stars",
                         @"brief_name":@"NL All-Stars",
                         }
                 };
    });
    return inst;
}

@end
