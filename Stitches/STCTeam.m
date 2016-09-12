//
//  STMLBTeam.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STCTeam.h"

@implementation STCTeam

- (instancetype)initWithCode:(NSString *)code fileCode:(NSString *)fileCode abbreviation:(NSString *)abbreviation name:(NSString *)name fullName:(NSString *)fullName briefName:(NSString *)briefName {
    self = [super init];
    if(self) {
        self.code = code;
        self.fileCode = fileCode;
        self.abbreviation = abbreviation;
        self.name = name;
        self.fullName = fullName;
        self.briefName = briefName;
    }
    
    return self;
}

- (NSString *)description {
    return self.fullName;
}

@end
