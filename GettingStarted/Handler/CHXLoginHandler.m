//
//  CHXLoginHandler.m
//  GettingStarted
//
//  Created by Moch Xiao on 12/1/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXLoginHandler.h"
#import "CHXLoginRequest.h"

@implementation CHXLoginHandler

+ (void)handleRequest:(CHXBaseRequest *)request withSuccess:(HandlerSuccessCompletionBlock)success failure:(HandlerFailureCompletionBlock)failure {
	[request startRequestWithSuccess:^(id responseData) {
		success(responseData);
	} failue:^(id errorMessage) {
		failure(errorMessage);
	}];
}

@end
