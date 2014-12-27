//
//  CHXDownloadRequest.m
//  GettingStarted
//
//  Created by Moch Xiao on 12/27/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
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
