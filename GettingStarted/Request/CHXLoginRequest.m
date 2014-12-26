//
//  CHXLoginRequest.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-01.
//	Copyright (c) 2014 Moch Xiao (htt://github.com/atcuan).
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

- (NSString *)requestBaseURLString {
	return  @"http://115.29.209.13:8081/wfarm/";
}

- (NSString *)requestSpecificURLString {
	return @"customerLogin/json/1";
}

//- (AFConstructingBlock)constructingBodyBlock {
////	AFConstructingBlock block = ^(id<AFMultipartFormData> formData) {
////	};
////	return block;
//	return ^(id<AFMultipartFormData> formData) {
//		
//	};
//}

- (NSTimeInterval)requestTimeoutInterval {
	return 2;
}



@end
