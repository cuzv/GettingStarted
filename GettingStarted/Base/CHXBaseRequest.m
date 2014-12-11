//
//  CHXBaseRequest.m
//  GettingStarted
//
//  Created by Moch Xiao on 12/10/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXBaseRequest.h"

@implementation CHXBaseRequest

#pragma mark - 

- (NSString *)baseURLString {
	return @"http://10.128.8.250:8080/wfarm/";
}

- (CHXRequestMethod)requestMehtod {
	return CHXRequestMethodPost;
}

- (CHXRequestSerializerType)requestSerializerType {
	return CHXRequestSerializerTypeJSON;
}

#pragma mark -

- (CHXResponseSerializerType)responseSerializerType {
	return CHXResponseSerializerTypeJSON;
}

- (NSString *)responseApiVersionFieldName {
	return @"api";
}

- (NSString *)responseCodeFieldName {
	return @"rspCode";
}

- (NSString *)responseDataFieldName {
	return @"rspData";
}

- (NSString *)responseMessageFieldName {
	return @"rspMsg";
}


@end
