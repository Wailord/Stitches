//
//  STMLBTeam.h
//  Stitches
//
//  Created by Ryan Fox on 9/2/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STCTeam : NSObject

@property NSString *code;
@property NSString *fileCode;
@property NSString *abbreviation;
@property NSString *name;
@property NSString *fullName;
@property NSString *briefName;

- (instancetype)initWithCode:(NSString *)code andFileCode:(NSString *)fileCode andAbbreviation:(NSString *)abbreviation andName:(NSString *)name andFullName:(NSString *)fullName andBriefName:(NSString *)briefName;

@end
