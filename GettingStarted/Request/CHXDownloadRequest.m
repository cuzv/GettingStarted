//
//  CHXDownloadRequest.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-27.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
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

#import "CHXDownloadRequest.h"
#import "CHXGlobalServices.h"

@implementation CHXDownloadRequest

- (NSDictionary *)requestParameters {
    return @{};
}

- (CHXRequestMethod)requestMehtod {
    return CHXRequestMethodGet;
}

- (NSString *)requestBaseURLString {
    return @"http://ww3.sinaimg.cn/large/";
}

- (NSString *)requestSpecificURLString {
    return @"62580dd9gw1ennijqvvghj21300n5jts.jpg";
}


- (NSString *)downloadTargetFilePathString {
    NSString *path = [chx_documentDirectory() stringByAppendingString:@"/sam.jpg"];
    return path;
}

- (NSTimeInterval)requestCacheDuration {
    return 60 * 10;
}


@end
