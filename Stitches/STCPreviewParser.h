//
//  STParseMLB.h
//  Stitches
//
//  Created by Ryan Fox on 9/1/16.
//  Copyright © 2016 Ryan Fox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCPreview.h"

@protocol STCPreviewParserDelegate
@required
-(void)parsedGamePreview:(STCPreview *)preview;
@end

@interface STCPreviewParser : NSObject
@property (nonatomic, weak) id<STCPreviewParserDelegate> delegate;

- (void)parsePreviewWithGameID:(NSString *)gameID;

@end
