//
//  HttpConfigure.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/19/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXHTTPConfigure.h"

@implementation CHXHTTPConfigure

NSTimeInterval const CHXTimeoutInterval = 10.0f;

//NSString *const CHXHTTPDebugBaseURL = @"http://www.raywenderlich.com/demos/weather_sample/";
//NSString *const CHXHTTPDebugBaseURL = @"http://www.team168.com/servlet/ci/3/";
NSString *const CHXHTTPDebugBaseURL = @"http://10.128.8.250:8080/wfarm/";
//NSString *const CHXHTTPDebugBaseURL = @"http://192.243.119.92/";
NSString *const CHXHTTPRealseBaseURL = @"";

NSString *const CHXHTTPParametersKey = @"key";
//NSString *const CHXHTTPParametersKey = @"paramJson";

NSString *const CHXHTTPContentTypeJavascript = @"text/javascript";
NSString *const CHXHTTPContentTypeAppJson = @"application/json";
NSString *const CHXHTTPContentTypeJson = @"text/json";

NSString *const CHXHTTPContentTypePlain = @"text/plain";
NSString *const CHXHTTPContentTypeHtml = @"text/html";

NSString *const CHXHTTPNetworkNotReachable = @"Network Error!";

@end
