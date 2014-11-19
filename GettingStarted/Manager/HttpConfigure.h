//
//  HttpConfigure.h
//  GettingStarted
//
//  Created by Moch on 11/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHHttpHeaders @{@"Accept": @"application/json"}

@interface HttpConfigure : NSObject

extern NSTimeInterval const CHTimeoutInterval;

extern NSString *const CHDebugHttpBaseURL;
extern NSString *const CHRealseHttpBaseURL;
extern NSString *const CHParametersKey;

extern NSString *const CHHttpContentTypeJavascript;
extern NSString *const CHHttpContentTypeAppJson;
extern NSString *const CHHttpContentTypeJson;

extern NSString *const CHHttpContentTypePlain;
extern NSString *const CHHttpContentTypeHtml;

extern NSString *const CHNetworkNotReachable;

@end
