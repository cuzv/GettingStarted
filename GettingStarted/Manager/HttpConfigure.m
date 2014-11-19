//
//  HttpConfigure.m
//  GettingStarted
//
//  Created by Moch on 11/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "HttpConfigure.h"

@implementation HttpConfigure

NSTimeInterval const CHTimeoutInterval = 10.0f;

//NSString *const CHDebugHttpBaseURL = @"http://www.raywenderlich.com/demos/weather_sample/";
NSString *const CHDebugHttpBaseURL = @"http://www.team168.com/servlet/ci/3/";
//NSString *const CHDebugHttpBaseURL = @"http://192.243.119.92/";
NSString *const CHRealseHttpBaseURL = @"";

NSString *const CHParametersKey = @"key";
//NSString *const CHParametersKey = @"paramJson";

NSString *const CHHttpContentTypeJavascript = @"text/javascript";
NSString *const CHHttpContentTypeAppJson = @"application/json";
NSString *const CHHttpContentTypeJson = @"text/json";

NSString *const CHHttpContentTypePlain = @"text/plain";
NSString *const CHHttpContentTypeHtml = @"text/html";

NSString *const CHNetworkNotReachable = @"Network Error!";

@end
