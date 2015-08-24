//
//  CHXHTTPConfigure.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-19.
//  Copyright (c) 2014 Moch Xiao (https://github.com/cuzv).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
