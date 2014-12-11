//
//  CHXRequestProxy.m
//  GettingStarted
//
//  Created by Moch Xiao on 12/2/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXRequestProxy.h"
#import "AFNetworking.h"
#import "CHXRequest.h"

const NSInteger kMaxConcurrentOperationCount = 4;
const NSTimeInterval kTimeoutInterval = 3.0f; // FIXME

@interface CHXRequestProxy ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableDictionary *dataTaskContainer;
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
		_sessionManager = [AFHTTPSessionManager manager];
		_sessionManager.operationQueue.maxConcurrentOperationCount = kMaxConcurrentOperationCount;
		_dataTaskContainer = [NSMutableDictionary new];
	}
	
	return self;
}

#pragma mark -

- (void)addRequest:(CHXRequest *)request {
	// HTTP Method
	CHXRequestMethod requestMethod = [request requestMehtod];
	NSParameterAssert(requestMethod != CHXRequestMethodNone);
	
	// HTTP API absolute URL
	NSString *requestAbsoluteURLString = [self __requestAbsoluteURLStringWithRequest:request];
	
	// HTTP POST value block
	AFConstructingBlock constructingBodyBlock = [request constructingBodyBlock];
	
	// SerializerType
	[self __settingupRequestSerializerTypeByRequest:request];
	[self __settingupResponseSerializerTypeByRequest:request];
	
	// HTTP Request parameters
	NSDictionary *requestParameters = [request requestParameters];
	NSParameterAssert(requestParameters);
	
	// Start request
	NSURLSessionDataTask *dataTask = nil;
	switch (requestMethod) {
		case CHXRequestMethodPost: {
			dataTask = [_sessionManager POST:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
				[self __handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
			} failure:^(NSURLSessionDataTask *task, NSError *error) {
				[self __handleRequestFailureWithSessionDataTask:task error:error];
			}];
		}
			break;
			
		case CHXRequestMethodGet: {
			
		}
			break;
		case CHXRequestMethodPut: {
			
		}
			break;
		case CHXRequestMethodDelete: {
			
		}
			break;
		case CHXRequestMethodPatch: {
			
		}
			break;
		case CHXRequestMethodHead: {
			
		}
			break;
		default:
			break;
	}
	
	// Connect Request and Data task
	request.requestSessionTask = dataTask;

	// Record the request task
	_dataTaskContainer[@(dataTask.taskIdentifier)] = request;
}

- (NSString *)__requestAbsoluteURLStringWithRequest:(CHXRequest *)request {
	// HTTP API BaseURLString
	NSString *baseRULString = [request baseURLString];
	NSParameterAssert(baseRULString);
	NSParameterAssert(baseRULString.length);
	
	// HTTP API specificURLString
	NSString *specificURLString = [request specificURLString];
	NSParameterAssert(specificURLString);
	NSParameterAssert(specificURLString.length);

	// Validate URL String
	BOOL endsWithSlash = [baseRULString characterAtIndex:baseRULString.length - 1] == '/';
	BOOL startWithSlash = [specificURLString characterAtIndex:0] == '/';
	BOOL correctCompleComponentsAppending = endsWithSlash ^ startWithSlash;
	NSAssert(correctCompleComponentsAppending, @"Request URL appending error!");
	
	return [NSString stringWithFormat:@"%@%@", baseRULString, specificURLString];
}

- (void)__settingupRequestSerializerTypeByRequest:(CHXRequest *)request {
	CHXRequestSerializerType requestSerializerType = [request requestSerializerType];
	NSParameterAssert(requestSerializerType != CHXRequestSerializerTypeNone);
	
	switch (requestSerializerType) {
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

- (void)__settingupResponseSerializerTypeByRequest:(CHXRequest *)request {
	CHXResponseSerializerType responseSerializerType = [request responseSerializerType];
	NSParameterAssert(responseSerializerType != CHXResponseSerializerTypeNone);
	
	switch (responseSerializerType) {
		case CHXResponseSerializerTypeJSON:
			_sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
			break;
			// TODO
		default:
			_sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
			break;
	}
}

// TODO
- (void)__handleRequestSuccessWithSessionDataTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject {
	CHXRequest *request = [_dataTaskContainer objectForKey:@(task.taskIdentifier)];
}

// TODO
- (void)__handleRequestFailureWithSessionDataTask:(NSURLSessionDataTask *)task error:(NSError *)error {
	CHXRequest *request = [_dataTaskContainer objectForKey:@(task.taskIdentifier)];
}


#pragma mark -

- (void)cancelRequest:(CHXRequest *)request {
	[request.requestSessionTask cancel];
	[_dataTaskContainer removeObjectForKey:@(request.requestSessionTask.taskIdentifier)];
}

#pragma mark -

- (void)cancelAllRequest {
	for (NSURLSessionTask *task in _sessionManager.tasks) {
		[task cancel];
	}
	
	[_sessionManager.operationQueue cancelAllOperations];
	
	[_dataTaskContainer removeAllObjects];
}

@end
