//
//  CHXRequest.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/30/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXRequest.h"
#import "CHXRequestProxy.h"
#import "CHXMacro.h"

@interface CHXRequest ()
@end

@implementation CHXRequest

- (void)dealloc {
	NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Subclass should overwrite

- (NSDictionary *)requestParameters {
	return nil;
}

- (NSString *)requestBaseURLString {
	return nil;
}

- (NSString *)requestSpecificURLString {
	return nil;;
}

- (CHXRequestMethod)requestMehtod {
	return CHXRequestMethodNone;
}

- (CHXRequestSerializerType)requestSerializerType {
	return CHXRequestSerializerTypeNone;
}

- (AFConstructingBlock)constructingBodyBlock {
	return nil;
}

- (NSTimeInterval)requestTimeoutInterval {
	return 10;
}

- (BOOL)requestNeedCache {
	return YES;
}

- (NSTimeInterval)requestCacheDuration {
	return 60 * 3;
}

#pragma mark - Collect response infos

- (CHXResponseSerializerType)responseSerializerType {
	return CHXResponseSerializerTypeNone;
}

- (NSString *)responseApiVersionFieldName {
	return nil;
}

- (NSString *)responseDataFieldName {
	return nil;
}

- (NSString *)responseCodeFieldName {
	return nil;
}

- (NSString *)responseMessageFieldName {
	return nil;
}

#pragma mark - Request

- (void)startRequestWithSuccess:(RequestSuccessCompletionBlock)success failue:(RequestFailureCompletionBlock)failure {
	[self __setCompletionBlockWithSuccess:success failue:failure];
	[self startRequest];
}

- (void)__setCompletionBlockWithSuccess:(RequestSuccessCompletionBlock)success failue:(RequestFailureCompletionBlock)failure {
	self.requestSuccessCompletionBlock = success;
	self.requestFailureCompletionBlock = failure;
}

- (void)startRequest {
	[[CHXRequestProxy sharedInstance] addRequest:self];
}

@end
