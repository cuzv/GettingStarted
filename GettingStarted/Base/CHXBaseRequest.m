//
//  CHXBaseRequest.m
//  GettingStarted
//
//  Created by Moch Xiao on 12/10/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXBaseRequest.h"

@implementation CHXBaseRequest

- (NSString *)baseURLString {
	return @"http://www.foobar.com/demo/json/3/";
}

- (NSString *)specificURLString {
	return nil;
}

- (CHXRequestMethod)requestMehtod {
	return CHXRequestMethodPost;
}

- (CHXRequestSerializerType)requestSerializerType {
	return CHXRequestSerializerTypeJSON;
}


@end
