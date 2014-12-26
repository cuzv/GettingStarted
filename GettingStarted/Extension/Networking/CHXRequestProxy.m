//
//  CHXRequestProxy.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-02.
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
		// When background download file complete, but move to target path failure, will post this notification
		[[NSNotificationCenter defaultCenter] addObserverForName:AFURLSessionDownloadTaskDidFailToMoveFileNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification *note) {
			// TODO
		}];
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
	if (![self pr_isNetworkReachable]) {
		// The first time description is not correct !
		NSString *errorDescription = @"The network is currently unreachable.";
		if (request.requestFailureCompletionBlock) {
			request.requestFailureCompletionBlock(errorDescription);
		}
		[self pr_clearCompletionBlockForRequest:request];
		NSLog(@"%@", errorDescription);
		return;
	}
	
	// Start request
	NSURLSessionTask *dataTask = nil;
	NSDictionary *requestParameters = nil;

	NSURLRequest *customRULRequest = [request customURLRequest];
	if (customRULRequest) {
		NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
		AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
		dataTask = [sessionManager dataTaskWithRequest:customRULRequest completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
			if (error) {
				[self pr_handleRequestFailureWithSessionDataTask:dataTask error:error];
			} else {
				[self pr_handleRequestSuccessWithSessionDataTask:dataTask responseObject:responseObject];
			}
		}];
		[dataTask resume];
	} else {
		// HTTP Method
		CHXRequestMethod requestMethod = [request requestMehtod];
		NSAssert(requestMethod <= CHXRequestMethodHead, @"Unsupport Request Method");
		NSAssert(requestMethod >= CHXRequestMethodPost, @"Unsupport Request Method");
		
		// HTTP API absolute URL
		NSString *requestAbsoluteURLString = [self pr_requestAbsoluteURLStringWithRequest:request];
		
		// HTTP POST value block
		AFConstructingBlock constructingBodyBlock = [request constructingBodyBlock];
		
		// SerializerType
		[self pr_settingupRequestSerializerTypeByRequest:request];
		[self pr_settingupResponseSerializerTypeByRequest:request];
		
		// HTTP Request parameters
		requestParameters = [request requestParameters];
		NSParameterAssert(requestParameters);

		switch (requestMethod) {
			case CHXRequestMethodPost: {
				if (constructingBodyBlock) {
					dataTask = [_sessionManager POST:requestAbsoluteURLString parameters:requestParameters constructingBodyWithBlock:constructingBodyBlock success:^(NSURLSessionDataTask *task, id responseObject) {
						[self pr_handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
					} failure:^(NSURLSessionDataTask *task, NSError *error) {
						[self pr_handleRequestFailureWithSessionDataTask:task error:error];
					}];
				} else {
					dataTask = [_sessionManager POST:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
						[self pr_handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
					} failure:^(NSURLSessionDataTask *task, NSError *error) {
						[self pr_handleRequestFailureWithSessionDataTask:task error:error];
					}];
				}
			}
				break;
			case CHXRequestMethodGet: {
				NSString *downloadTargetPath = [request downloadTargetPathString];
				if (downloadTargetPath) {
					NSParameterAssert(downloadTargetPath.length);
					
					NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
					AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
					// TODO fileRemoteURL
					NSURL *fileRemoteURL = [NSURL URLWithString:nil];
					NSURLRequest *downURLRequest = [NSURLRequest requestWithURL:fileRemoteURL];
					NSURLSessionTask *dataTask = [sessionManager downloadTaskWithRequest:downURLRequest progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
						return [NSURL URLWithString:downloadTargetPath];
					} completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
						if (error) {
							[self pr_handleRequestFailureWithSessionDataTask:dataTask error:error];
						} else {
							[self pr_handleRequestSuccessWithSessionDataTask:dataTask responseObject:nil];
						}
					}];
					// If download on background
					[sessionManager setDownloadTaskDidFinishDownloadingBlock:^NSURL *(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, NSURL *location) {
						return [NSURL URLWithString:downloadTargetPath];
					}];
					[dataTask resume];

				} else {
					dataTask = [_sessionManager GET:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
						[self pr_handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
					} failure:^(NSURLSessionDataTask *task, NSError *error) {
						[self pr_handleRequestFailureWithSessionDataTask:task error:error];
					}];
				}
			}
				break;
			case CHXRequestMethodPut: {
				dataTask = [_sessionManager PUT:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
					[self pr_handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
				} failure:^(NSURLSessionDataTask *task, NSError *error) {
					[self pr_handleRequestFailureWithSessionDataTask:task error:error];
				}];
			}
				break;
			case CHXRequestMethodDelete: {
				dataTask = [_sessionManager DELETE:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
					[self pr_handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
				} failure:^(NSURLSessionDataTask *task, NSError *error) {
					[self pr_handleRequestFailureWithSessionDataTask:task error:error];
				}];
			}
				break;
			case CHXRequestMethodPatch: {
				dataTask = [_sessionManager PATCH:requestAbsoluteURLString parameters:requestParameters success:^(NSURLSessionDataTask *task, id responseObject) {
					[self pr_handleRequestSuccessWithSessionDataTask:task responseObject:responseObject];
				} failure:^(NSURLSessionDataTask *task, NSError *error) {
					[self pr_handleRequestFailureWithSessionDataTask:task error:error];
				}];
			}
				break;
			case CHXRequestMethodHead: {
				dataTask = [_sessionManager HEAD:requestAbsoluteURLString parameters:requestAbsoluteURLString success:^(NSURLSessionDataTask *task) {
					[self pr_handleRequestSuccessWithSessionDataTask:task responseObject:nil];
				} failure:^(NSURLSessionDataTask *task, NSError *error) {
					[self pr_handleRequestFailureWithSessionDataTask:task error:error];
				}];
			}
				break;
			default:
				break;
		}
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

- (BOOL)pr_isNetworkReachable {
	return [_sessionManager.reachabilityManager isReachable];
}

- (NSString *)pr_requestAbsoluteURLStringWithRequest:(CHXRequest *)request {
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
	
	NSString *suffixURLString = [request requestSuffixURLString];
	if (suffixURLString && suffixURLString.length) {
		endsWithSlash = [specificURLString characterAtIndex:specificURLString.length - 1] == '/';
		startWithSlash = [suffixURLString characterAtIndex:0] == '/';
		correctCompleComponentsAppending = endsWithSlash ^ startWithSlash;
		NSAssert(correctCompleComponentsAppending, @"Request URL appending error!");
	}
	
	return [NSString stringWithFormat:@"%@%@", baseRULString, specificURLString];
}

- (void)pr_settingupRequestSerializerTypeByRequest:(CHXRequest *)request {
	CHXRequestSerializerType requestSerializerType = [request requestSerializerType];
	NSParameterAssert(requestSerializerType >= CHXRequestSerializerTypeHTTP);
	NSParameterAssert(requestSerializerType <= CHXRequestSerializerTypeJSON);
	
	switch (requestSerializerType) {
		case CHXRequestSerializerTypeJSON:
			_sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
			break;
		default:
			_sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
			break;
	}
	
	_sessionManager.requestSerializer.timeoutInterval = [request requestTimeoutInterval];
}

- (void)pr_settingupResponseSerializerTypeByRequest:(CHXRequest *)request {
	CHXResponseSerializerType responseSerializerType = [request responseSerializerType];
	NSParameterAssert(responseSerializerType >= CHXResponseSerializerTypeHTTP);
	NSParameterAssert(responseSerializerType <= CHXResponseSerializerTypeImage);
	
	switch (responseSerializerType) {
		case CHXResponseSerializerTypeJSON:
			_sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
			break;
		case CHXResponseSerializerTypeImage:
			_sessionManager.responseSerializer = [AFImageResponseSerializer serializer];
			break;
		default:
			_sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
			break;
	}
}

// TODO
- (void)pr_handleRequestSuccessWithSessionDataTask:(NSURLSessionTask *)task responseObject:(id)responseObject {
	CHXRequest *request = [_dataTaskContainer objectForKey:@(task.taskIdentifier)];
	NSParameterAssert(request);
	
	if (request.requestSuccessCompletionBlock) {
		NSString *responseCodeFieldName = [request responseCodeFieldName];
		NSParameterAssert(responseCodeFieldName);
		NSParameterAssert(responseCodeFieldName.length);
		
		id responseCode = [responseObject objectForKey:responseCodeFieldName];
		if ([responseCode integerValue] == 0) {
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
	[self pr_prepareDeallocRequest:request];
}

// TODO
- (void)pr_handleRequestFailureWithSessionDataTask:(NSURLSessionTask *)task error:(NSError *)error {
	NSLog(@"Request error: %@", error);
	CHXRequest *request = [_dataTaskContainer objectForKey:@(task.taskIdentifier)];
	NSParameterAssert(request);
	
	if (request.requestFailureCompletionBlock) {
		request.requestFailureCompletionBlock([error localizedDescription]);
	}
	[self pr_prepareDeallocRequest:request];
}

- (void)pr_prepareDeallocRequest:(CHXRequest *)request {
	// Remove contain from data task container
	[self pr_removeContainForRequest:request];

	// Clear callback block
	[self pr_clearCompletionBlockForRequest:request];
	
	// Break retain data task
	request.requestSessionTask = nil;
}

- (void)pr_removeContainForRequest:(CHXRequest *)request {
	[_dataTaskContainer removeObjectForKey:@(request.requestSessionTask.taskIdentifier)];
}

- (void)pr_clearCompletionBlockForRequest:(CHXRequest *)request {
	request.requestSuccessCompletionBlock = nil;
	request.requestFailureCompletionBlock = nil;
}

#pragma mark -

- (void)cancelRequest:(CHXRequest *)request {
	[request.requestSessionTask cancel];
	[self pr_prepareDeallocRequest:request];
}

#pragma mark -

- (void)cancelAllRequest {
	[_sessionManager.operationQueue cancelAllOperations];
	
	__weak typeof(self) weakSelf = self;
	[self.dataTaskContainer enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
		if ([obj isKindOfClass:[CHXRequest class]]) {
			CHXRequest *request = (CHXRequest *)obj;
			[weakSelf cancelRequest:request];
		}
	}];
}

@end
