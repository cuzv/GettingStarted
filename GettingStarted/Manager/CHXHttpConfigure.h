//
//  HttpConfigure.h
//  GettingStarted
//
//  Created by Moch Xiao on 11/19/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHXHTTPHeaders @{@"Accept": @"application/json"}

@interface CHXHTTPConfigure : NSObject

extern NSTimeInterval const CHXTimeoutInterval;

extern NSString *const CHXHTTPDebugBaseURL;
extern NSString *const CHXHTTPRealseBaseURL;
extern NSString *const CHXHTTPParametersKey;

extern NSString *const CHXHTTPContentTypeJavascript;
extern NSString *const CHXHTTPContentTypeAppJson;
extern NSString *const CHXHTTPContentTypeJson;

extern NSString *const CHXHTTPContentTypePlain;
extern NSString *const CHXHTTPContentTypeHtml;

extern NSString *const CHXHTTPNetworkNotReachable;

@end
