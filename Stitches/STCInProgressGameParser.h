//
//  STCInProgressGameParser.h
//  Stitches
//
//  Created by Ryan Fox on 9/12/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCInProgressGame.h"

@protocol STCInProgressParserDelegate
@required
-(void)parsedInProgressGame:(STCInProgressGame *)preview;
@end

@interface STCInProgressGameParser : NSObject<NSXMLParserDelegate>
@property (nonatomic, weak) id<STCInProgressParserDelegate> delegate;

- (void)parseInProgressGameWithID:(NSString *)gameID;


@end
