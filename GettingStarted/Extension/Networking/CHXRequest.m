//
//  CHXRequest.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/30/14.
//	Copyright (c) 2014 Moch Xiao (http://www.github.com/atcuan)
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
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

- (NSString *)requestSuffixURLString {
	return nil;
}

- (CHXRequestMethod)requestMehtod {
	return CHXRequestMethodPost;
}

- (CHXRequestSerializerType)requestSerializerType {
	return CHXRequestSerializerTypeHTTP;
}

- (AFConstructingBlock)constructingBodyBlock {
	return nil;
}

- (NSURLRequest *)customURLRequest {
	return nil;
}

- (NSString *)downloadTargetPathString {
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
	return CHXResponseSerializerTypeJSON;
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

- (void)stopRequest {
	[[CHXRequestProxy sharedInstance] cancelRequest:self];
}

- (void)__setCompletionBlockWithSuccess:(RequestSuccessCompletionBlock)success failue:(RequestFailureCompletionBlock)failure {
	self.requestSuccessCompletionBlock = success;
	self.requestFailureCompletionBlock = failure;
}

- (void)startRequest {
	[[CHXRequestProxy sharedInstance] addRequest:self];
}

@end
