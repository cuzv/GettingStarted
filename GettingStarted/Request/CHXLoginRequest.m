//
//  CHXLoginRequest.m
//  GettingStarted
//
//  Created by Moch Xiao on 12/1/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXLoginRequest.h"

@interface CHXLoginRequest ()

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end

@implementation CHXLoginRequest

- (instancetype)initWithUsername:(NSString *)userName password:(NSString *)password {
	if (self = [super init]) {
		_username = userName;
		_password = password;
	}
	
	return self;
}


- (NSDictionary *)requestParameters {
	return @{@"uAccount":_username,
			 @"uPass":_password
			 };
}

- (NSString *)baseURLString {
	return  @"http://10.128.8.250:8080/wfarm/customerLogin/json/1";
}

- (NSString *)specificURLString {
	return @"";
}

- (AFConstructingBlock)constructingBodyBlock {
//	AFConstructingBlock block = ^(id<AFMultipartFormData> formData) {
//	};
//	return block;
	return ^(id<AFMultipartFormData> formData) {
		
	};
}


@end
