//
//  CHXNetworking.h
//  GettingStarted
//
//  Created by Moch Xiao on 12/2/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#ifndef GettingStarted_CHXNetworking_h
#define GettingStarted_CHXNetworking_h

#pragma mark -

typedef NS_ENUM(NSInteger, CHXRequestMethod) {
	CHXRequestMethodGet = 0,
	CHXRequestMethodPost,
	CHXRequestMethodHead,
	CHXRequestMethodPut,
	CHXRequestMethodDelete,
};

#pragma mark -

@protocol CHXGeneralPublicField <NSObject>

@required
- (NSString *)baseUrl;
- (NSString *)requestUrl;
- (id)requestParameters;
- (CHXRequestMethod)requestMethod;

@optional
- (NSString *)cdnUrl;

@end


#endif
