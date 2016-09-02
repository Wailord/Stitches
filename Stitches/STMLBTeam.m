//
//  STMLBTeam.m
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import "STMLBTeam.h"

@implementation STMLBTeam

- (instancetype)initWithCode:(NSString *)code andFileCode:(NSString *)fileCode andAbbreviation:(NSString *)abbreviation andName:(NSString *)name andFullName:(NSString *)fullName andBriefName:(NSString *)briefName {
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
