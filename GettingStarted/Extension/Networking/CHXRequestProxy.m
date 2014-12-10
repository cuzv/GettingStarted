//
//  CHXRequestProxy.m
//  GettingStarted
//
//  Created by Moch Xiao on 12/2/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXRequestProxy.h"
#import "CHXRequestConfiguration.h"
#import "AFNetworking.h"
#import "CHXRequest.h"

const NSInteger kMaxConcurrentOperationCount = 4;
const NSTimeInterval kTimeoutInterval = 10.0f;

@interface CHXRequestProxy ()
@property (nonatomic, strong) CHXRequestConfiguration *requestConfiguration;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation CHXRequestProxy

+ (instancetype)sharedInstance {
	static CHXRequestProxy *_sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [self new];
	});
	
	return _sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		_requestConfiguration = [CHXRequestConfiguration sharedInstance];
		_sessionManager = [AFHTTPSessionManager manager];
		_sessionManager.operationQueue.maxConcurrentOperationCount = kMaxConcurrentOperationCount;
	}
	
	return self;
}

#pragma mark - Private

- (NSString *)__requestAbsoluteURLStringWithRequest:(CHXRequest *)request {
	// HTTP API BaseURLString
	NSString *baseRULString = [request baseURLString];
	NSParameterAssert(baseRULString);
	
	// HTTP API specificURLString
	NSString *specificURLString = [request specificURLString];
	NSParameterAssert(specificURLString);
	
	return [NSString stringWithFormat:@"%@%@", baseRULString, specificURLString];
}

- (void)__settingupRequestSerializerTypeByRequest:(CHXRequest *)request {
	switch ([request requestSerializerType]) {
		case CHXRequestSerializerTypeJSON:
			_sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
			break;
		// TODO
		default:
			_sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
			break;
	}
	
	_sessionManager.requestSerializer.timeoutInterval = kTimeoutInterval;
}

#pragma mark - Public

- (void)addRequest:(CHXRequest *)request {
	// 取出请求所需数据
	// HTTP Method
//	CHXRequestMethod requestMethod = [request requestMehtod];
	// HTTP API absolute URL
	NSString *requestAbsoluteURLString = [self __requestAbsoluteURLStringWithRequest:request];
	// HTTP POST value block
//	AFConstructingBlock constructingBodyBlock = [request constructingBodyBlock];
	// requestSerializerType
	[self __settingupRequestSerializerTypeByRequest:request];
	
	// HTTP Request parameters
	NSDictionary *requestParameters = [request requestParameters];
	
	[_sessionManager POST:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
		request.requestSuccessCompletionBlock(responseObject);
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		request.requestFailureCompletionBlock(error);
	}];
}

- (void)cancelRequest:(CHXRequest *)request {

}

- (void)cancelAllRequest {

}

@end
