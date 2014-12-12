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
#import "CHXMacro.h"

const NSInteger kMaxConcurrentOperationCount = 4;

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
		[_sessionManager.reachabilityManager startMonitoring];
		[_sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
			NSLog(@"AFNetworkReachabilityStatus: %@", AFStringFromNetworkReachabilityStatus(status));
		}];
		_dataTaskContainer = [NSMutableDictionary new];
	}
	
	return self;
}

/**
 *  `AFNetworkReachabilityManager` first request network status is always `AFNetworkReachabilityStatusUnknown`
 *  So, let it checking before formal request by start a invalid request.
 */
+ (void)load {
	[[CHXRequestProxy sharedInstance] addRequest:[CHXRequest new]];
}

#pragma mark -

- (void)addRequest:(CHXRequest *)request {
	// Checking Networking status
	if (![self __isNetworkReachable]) {
		// The first time description is not correct !
		NSString *errorDescription = @"The network is currently unreachable.";
		if (request.requestFailureCompletionBlock) {
			request.requestFailureCompletionBlock(errorDescription);
		}
		[self __clearCompletionBlockForRequest:request];
		NSLog(@"%@", errorDescription);
		return;
	}
	
	// HTTP Method
	CHXRequestMethod requestMethod = [request requestMehtod];
	NSAssert(requestMethod < CHXRequestMethodNone, @"Unsupport Request Method");
	NSAssert(requestMethod >= CHXRequestMethodPost, @"Unsupport Request Method");
	
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
	NSURLSessionTask *dataTask = nil;
	switch (requestMethod) {
		case CHXRequestMethodPost: {
			if (constructingBodyBlock) {
				dataTask = [_sessionManager POST:requestAbsoluteURLString parameters:requestParameters constructingBodyWithBlock:constructingBodyBlock success:^(NSURLSessionDataTask *task, id responseObject) {
					[self __handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
				} failure:^(NSURLSessionDataTask *task, NSError *error) {
					[self __handleRequestFailureWithSessionDataTask:task error:error];
				}];
			} else {
				dataTask = [_sessionManager POST:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
					[self __handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
				} failure:^(NSURLSessionDataTask *task, NSError *error) {
					[self __handleRequestFailureWithSessionDataTask:task error:error];
				}];
			}
		}
			break;
		case CHXRequestMethodGet: {
			dataTask = [_sessionManager GET:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
				[self __handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
			} failure:^(NSURLSessionDataTask *task, NSError *error) {
				[self __handleRequestFailureWithSessionDataTask:task error:error];
			}];
		}
			break;
		case CHXRequestMethodPut: {
			dataTask = [_sessionManager PUT:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
				[self __handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
			} failure:^(NSURLSessionDataTask *task, NSError *error) {
				[self __handleRequestFailureWithSessionDataTask:task error:error];
			}];
		}
			break;
		case CHXRequestMethodDelete: {
			dataTask = [_sessionManager DELETE:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
				[self __handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
			} failure:^(NSURLSessionDataTask *task, NSError *error) {
				[self __handleRequestFailureWithSessionDataTask:task error:error];
			}];
		}
			break;
		case CHXRequestMethodPatch: {
			dataTask = [_sessionManager PATCH:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
				[self __handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
			} failure:^(NSURLSessionDataTask *task, NSError *error) {
				[self __handleRequestFailureWithSessionDataTask:task error:error];
			}];
		}
			break;
		case CHXRequestMethodHead: {
			dataTask = [_sessionManager HEAD:requestAbsoluteURLString parameters:requestAbsoluteURLString success:^(NSURLSessionDataTask *task) {
				[self __handleRequestSuccessWithSessionDataTask:task responseObject:nil];
			} failure:^(NSURLSessionDataTask *task, NSError *error) {
				[self __handleRequestFailureWithSessionDataTask:task error:error];
			}];
		}
			break;
		default:
			break;
	}
	
	// Connect Request and Data task
	request.requestSessionTask = dataTask;

	// Record the request task
	_dataTaskContainer[@(dataTask.taskIdentifier)] = request;
	
	// For debug
	NSLog(@"\n");
	NSLog(@"Request Start!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
	NSLog(@"Request API URL: %@\n", dataTask.currentRequest.URL);
	NSLog(@"Request parameters: %@\n", requestParameters);
	NSLog(@"Reuquest Header: %@\n", dataTask.currentRequest.allHTTPHeaderFields);
	NSLog(@"Request Log End!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
}

- (BOOL)__isNetworkReachable {
	return [_sessionManager.reachabilityManager isReachable];
}

- (NSString *)__requestAbsoluteURLStringWithRequest:(CHXRequest *)request {
	// HTTP API BaseURLString
	NSString *baseRULString = [request requestBaseURLString];
	NSParameterAssert(baseRULString);
	NSParameterAssert(baseRULString.length);
	
	// HTTP API specificURLString
	NSString *specificURLString = [request requestSpecificURLString];
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
	
	_sessionManager.requestSerializer.timeoutInterval = [request requestTimeoutInterval];
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
- (void)__handleRequestSuccessWithSessionDataTask:(NSURLSessionTask *)task responseObject:(id)responseObject {
	CHXRequest *request = [_dataTaskContainer objectForKey:@(task.taskIdentifier)];
	NSParameterAssert(request);
	
	if (request.requestSuccessCompletionBlock) {
		NSString *responseCodeFieldName = [request responseCodeFieldName];
		NSParameterAssert(responseCodeFieldName);
		NSParameterAssert(responseCodeFieldName.length);
		
		NSString *responseCode = [responseObject objectForKey:responseCodeFieldName];
		if ([responseCode isEqualToString:@"0"]) {
			NSString *responseDataFieldName = [request responseDataFieldName];
			NSParameterAssert(responseDataFieldName);
			NSParameterAssert(responseDataFieldName.length);
			
			id responseData = [responseObject objectForKey:responseDataFieldName];
			request.requestSuccessCompletionBlock(responseData);
		} else {
			if (request.requestFailureCompletionBlock) {
				NSString *responseMessageFieldName = [request responseMessageFieldName];
				NSParameterAssert(responseMessageFieldName);
				NSParameterAssert(responseMessageFieldName.length);

				id responseMessage = [responseObject objectForKey:responseMessageFieldName];
				request.requestFailureCompletionBlock(responseMessage);
			}
		}
		request.requestSuccessCompletionBlock(responseObject);
	}
	[self __prepareDeallocRequest:request];
}

// TODO
- (void)__handleRequestFailureWithSessionDataTask:(NSURLSessionTask *)task error:(NSError *)error {
	NSLog(@"Request error: %@", error);
	CHXRequest *request = [_dataTaskContainer objectForKey:@(task.taskIdentifier)];
	NSParameterAssert(request);
	
	if (request.requestFailureCompletionBlock) {
		request.requestFailureCompletionBlock([error localizedDescription]);
	}
	[self __prepareDeallocRequest:request];
}

- (void)__prepareDeallocRequest:(CHXRequest *)request {
	// Remove contain from data task container
	[self __removeContainForRequest:request];

	// Clear callback block
	[self __clearCompletionBlockForRequest:request];
	
	// Break retain data task
	request.requestSessionTask = nil;
}

- (void)__removeContainForRequest:(CHXRequest *)request {
	[_dataTaskContainer removeObjectForKey:@(request.requestSessionTask.taskIdentifier)];
}

- (void)__clearCompletionBlockForRequest:(CHXRequest *)request {
	request.requestSuccessCompletionBlock = nil;
	request.requestFailureCompletionBlock = nil;
}

#pragma mark -

- (void)cancelRequest:(CHXRequest *)request {
	[request.requestSessionTask cancel];
	[self __removeContainForRequest:request];
}

#pragma mark -

- (void)cancelAllRequest {
	for (NSURLSessionTask *task in _sessionManager.tasks) {
		[task cancel];
	}
	
	[_sessionManager.operationQueue cancelAllOperations];
	
	[self.dataTaskContainer removeAllObjects];
}

@end
