//
//  CHXRequest.h
//  GettingStarted
//
//  Created by Moch Xiao on 11/30/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 

typedef NS_ENUM(NSInteger, CHXRequestMethod) {
	CHXRequestMethodGet = 0,
	CHXRequestMethodPost,
	CHXRequestMethodHead
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

#pragma mark -

@interface CHXRequest : NSObject

@end
