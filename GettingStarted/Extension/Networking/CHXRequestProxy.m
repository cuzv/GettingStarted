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
#import "NSObjectExtension.h"

#pragma mark -

@interface CHXResponseCache : NSObject <NSCoding>
@property (nonatomic, strong) id cahceResponseObject;
@property (nonatomic, strong) NSDate *cacheDate;
@end

@implementation CHXResponseCache

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[[self chx_properties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[aCoder encodeObject:[self valueForKey:obj] forKey:obj];
	}];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super init]) {
		[[self chx_properties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			[self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
		}];
	}
	return self;
}

@end

#pragma mark -

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
			NSLog(@"AFURLSessionDownloadTaskDidFailToMoveFileNotification = %@", note);
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
		
		// Open networking activity indicator
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	} else {
		// If cache exist, return cache data
		if (![self pr_shouldContinueRequest:request]) {
			return;
		}
		
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

		// Open networking activity indicator
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		
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
				NSString *downloadTargetFilePath = [request downloadTargetFilePathString];
				if (![downloadTargetFilePath hasPrefix:@"file://"]) {
					downloadTargetFilePath = [@"file://" stringByAppendingString:downloadTargetFilePath];
				}
				if (downloadTargetFilePath) {
					NSParameterAssert(downloadTargetFilePath.length);
					
					NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
					AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
					// fileRemoteURL
					NSString *fileRemoteURLString = [self pr_requestFileRemoteURLStringWithRequest:request];
					NSURL *fileRemoteURL = [NSURL URLWithString:fileRemoteURLString];
					NSURLRequest *downURLRequest = [NSURLRequest requestWithURL:fileRemoteURL];
					dataTask = [sessionManager downloadTaskWithRequest:downURLRequest progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
						return [NSURL URLWithString:downloadTargetFilePath];
					} completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
						if (error) {
							[self pr_handleRequestFailureWithSessionDataTask:request.requestSessionTask error:error];
						} else {
							id object = [self pr_buildResponseObject:filePath forRequest:request];
							[self pr_handleRequestSuccessWithSessionDataTask:request.requestSessionTask responseObject:object];
						}
					}];
					// If download on background
					[sessionManager setDownloadTaskDidFinishDownloadingBlock:^NSURL *(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, NSURL *location) {
						return [NSURL URLWithString:downloadTargetFilePath];
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
	NSLog(@"\n%@\n%@\n%@\n", dataTask.currentRequest.URL, requestParameters, dataTask.currentRequest.allHTTPHeaderFields);
}

- (void)cancelRequest:(CHXRequest *)request {
	[request.requestSessionTask cancel];
	[self pr_prepareDeallocRequest:request];
}

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

#pragma mark -

- (BOOL)pr_isNetworkReachable {
	return [_sessionManager.reachabilityManager isReachable];
}

- (BOOL)pr_shouldContinueRequest:(CHXRequest *)request {
	// Need cache ?
	if (![request requestNeedCache]) {
		return YES;
	}
	
	// If cache data not exist, should continure request
	CHXResponseCache *cacheResponse = [self pr_cacheForRequest:request];
	if (!cacheResponse.cahceResponseObject || !cacheResponse.cacheDate) {
		return YES;
	}
	
	NSTimeInterval interval = -[cacheResponse.cacheDate timeIntervalSinceNow];
	NSTimeInterval duration = request.requestCacheDuration;
	if (interval > duration) {
		return YES;
	}
	// handle request success
	[self pr_handleRequestSuccessWithRequest:request responseObject:cacheResponse.cahceResponseObject];
	
	// dealloc request
	[self pr_prepareDeallocRequest:request];
	
	return NO;
}

- (CHXResponseCache *)pr_cacheForRequest:(CHXRequest *)request {
	// Retrieve cache data
	NSString *filePath = [self pr_cacheFilePathStringForReqeust:request];
	CHXResponseCache *cache = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

	return cache;
}

- (void)pr_cacheIfNeededWithRequest:(CHXRequest *)request responseObject:(id)responseObject {
	if (![request requestNeedCache]) {
		return;
	}
	
	// Cache file path
	NSString *filePath = [self pr_cacheFilePathStringForReqeust:request];

	// Cache data
	CHXResponseCache *cache = [CHXResponseCache new];
	cache.cacheDate = [NSDate date];
	cache.cahceResponseObject = responseObject;
	[NSKeyedArchiver archiveRootObject:cache toFile:filePath];
}

- (NSString *)pr_cacheFilePathStringForReqeust:(CHXRequest *)request {
	NSString *fileName = nil;
	if (request.chx_properties.count) {
		fileName = [NSString stringWithFormat:@"%zd", [request hash]];
	} else {
		fileName = NSStringFromClass([request class]);
	}
	
	NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:fileName];
	return filePath;
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

- (NSString *)pr_requestFileRemoteURLStringWithRequest:(CHXRequest *)request {
	NSString *originalURLString = [self pr_requestAbsoluteURLStringWithRequest:request];
	NSString *parametersURLString = [self pr_buildParametersToURLStringWithRequest:request];
	NSString *resultURLString = [NSString stringWithString:originalURLString];
	
	if (parametersURLString && parametersURLString.length) {
		if ([originalURLString rangeOfString:@"?"].location != NSNotFound) {
			resultURLString = [resultURLString stringByAppendingString:parametersURLString];
		} else {
			resultURLString = [resultURLString stringByAppendingFormat:@"?%@", [parametersURLString substringFromIndex:1]];
		}
		return resultURLString;
	} else {
		return originalURLString;
	}
}

- (NSString *)pr_buildParametersToURLStringWithRequest:(CHXRequest *)request {
	NSDictionary *parameters = request.requestParameters;
	
	NSMutableString *parametersURLString = [@"" mutableCopy];
	if (parameters && parameters.count) {
		for (NSString *key in parameters) {
			NSString *value = parameters[key];
			value = [NSString stringWithFormat:@"%@", value];
			value = [self pr_URLEncode:value];
			[parametersURLString appendFormat:@"&%@=%@", key, value];
		}
	}
	
	return [NSString stringWithString:parametersURLString];
}


- (NSString *)pr_URLEncode:(NSString *)string {
	// https://github.com/AFNetworking/AFNetworking/pull/555
	NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																							 (__bridge CFStringRef)string,
																							 CFSTR("."),
																							 CFSTR(":/?#[]@!$&'()*+,;="),
																							 kCFStringEncodingUTF8);
	return result;
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

- (void)pr_handleRequestSuccessWithSessionDataTask:(NSURLSessionTask *)task responseObject:(id)responseObject {
	if (!responseObject) {
		return;
	}
	CHXRequest *request = [_dataTaskContainer objectForKey:@(task.taskIdentifier)];
	NSParameterAssert(request);

	[self pr_cacheIfNeededWithRequest:request responseObject:responseObject];
	[self pr_handleRequestSuccessWithRequest:request responseObject:responseObject];
	[self pr_prepareDeallocRequest:request];
}

- (id)pr_buildResponseObject:(id)responseObject forRequest:(CHXRequest *)request {
	NSString *responseCodeFieldName = [request responseCodeFieldName];
	NSParameterAssert(responseCodeFieldName);
	NSParameterAssert(responseCodeFieldName.length);
	
	NSString *responseDataFieldName = [request responseDataFieldName];
	NSParameterAssert(responseDataFieldName);
	NSParameterAssert(responseDataFieldName.length);

	NSDictionary *returnObject = @{responseCodeFieldName:@"0", responseDataFieldName:responseObject};
	
	return returnObject;
}

- (void)pr_handleRequestSuccessWithRequest:(CHXRequest *)request responseObject:(id)responseObject {
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
	}
}

- (void)pr_handleRequestFailureWithSessionDataTask:(NSURLSessionTask *)task error:(NSError *)error {
	NSLog(@"Request error: %@", CHXStringFromCFNetworkErrorCode(error.code));
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
	
	// Close networking activity indicator
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)pr_removeContainForRequest:(CHXRequest *)request {
	[_dataTaskContainer removeObjectForKey:@(request.requestSessionTask.taskIdentifier)];
}

- (void)pr_clearCompletionBlockForRequest:(CHXRequest *)request {
	request.requestSuccessCompletionBlock = nil;
	request.requestFailureCompletionBlock = nil;
}

#pragma mark - Utils

NSString *CHXStringFromCFNetworkErrorCode(NSInteger code) {
	NSString *resultString = nil;
	switch (code) {
		case kCFHostErrorHostNotFound:
			resultString = @"kCFHostErrorHostNotFound";
			break;
		case kCFHostErrorUnknown:
			resultString = @"kCFHostErrorUnknown";
			break;
		case kCFSOCKSErrorUnknownClientVersion:
			resultString = @"kCFSOCKSErrorUnknownClientVersion";
			break;
		case kCFSOCKSErrorUnsupportedServerVersion:
			resultString = @"kCFSOCKSErrorUnsupportedServerVersion";
			break;
		case kCFSOCKS4ErrorRequestFailed:
			resultString = @"kCFSOCKS4ErrorRequestFailed";
			break;
		case kCFSOCKS4ErrorIdentdFailed:
			resultString = @"kCFSOCKS4ErrorIdentdFailed";
			break;
		case kCFSOCKS4ErrorIdConflict:
			resultString = @"kCFSOCKS4ErrorIdConflict";
			break;
		case kCFSOCKS5ErrorBadState:
			resultString = @"kCFSOCKS5ErrorBadState";
			break;
		case kCFSOCKS5ErrorBadResponseAddr:
			resultString = @"kCFSOCkCFSOCKS5ErrorBadResponseAddrKS5ErrorBadState";
			break;
		case kCFSOCKS5ErrorBadCredentials:
			resultString = @"kCFSOCKS5ErrorBadCredentials";
			break;
		case kCFSOCKS5ErrorUnsupportedNegotiationMethod:
			resultString = @"kCFSOCKS5ErrorUnsupportedNegotiationMethod";
			break;
		case kCFSOCKS5ErrorNoAcceptableMethod:
			resultString = @"kCFSOCKS5ErrorNoAcceptableMethod";
			break;
		case kCFFTPErrorUnexpectedStatusCode:
			resultString = @"kCFFTPErrorUnexpectedStatusCode";
			break;
		case kCFErrorHTTPAuthenticationTypeUnsupported:
			resultString = @"kCFErrorHTTPAuthenticationTypeUnsupported";
			break;
		case kCFErrorHTTPBadCredentials:
			resultString = @"kCFErrorHTTPBadCredentials";
			break;
		case kCFErrorHTTPConnectionLost:
			resultString = @"kCFErrorHTTPConnectionLost";
			break;
		case kCFErrorHTTPParseFailure:
			resultString = @"kCFErrorHTTPParseFailure";
			break;
		case kCFErrorHTTPRedirectionLoopDetected:
			resultString = @"kCFErrorHTTPRedirectionLoopDetected";
			break;
		case kCFErrorHTTPBadURL:
			resultString = @"kCFErrorHTTPBadURL";
			break;
		case kCFErrorHTTPProxyConnectionFailure:
			resultString = @"kCFErrorHTTPProxyConnectionFailure";
			break;
		case kCFErrorHTTPBadProxyCredentials:
			resultString = @"kCFErrorHTTPBadProxyCredentials";
			break;
		case kCFErrorPACFileError:
			resultString = @"kCFErrorPACFileError";
			break;
		case kCFErrorPACFileAuth:
			resultString = @"kCFErrorPACFileAuth";
			break;
		case kCFErrorHTTPSProxyConnectionFailure:
			resultString = @"kCFErrorHTTPSProxyConnectionFailure";
			break;
		case kCFStreamErrorHTTPSProxyFailureUnexpectedResponseToCONNECTMethod:
			resultString = @"kCFStreamErrorHTTPSProxyFailureUnexpectedResponseToCONNECTMethod";
			break;
		case kCFURLErrorBackgroundSessionInUseByAnotherProcess:
			resultString = @"kCFURLErrorBackgroundSessionInUseByAnotherProcess";
			break;
		case kCFURLErrorBackgroundSessionWasDisconnected:
			resultString = @"kCFURLErrorBackgroundSessionWasDisconnected";
			break;
		case kCFURLErrorUnknown:
			resultString = @"kCFURLErrorUnknown";
			break;
		case kCFURLErrorCancelled:
			resultString = @"kCFURLErrorCancelled";
			break;
		case kCFURLErrorBadURL:
			resultString = @"kCFURLErrorBadURL";
			break;
		case kCFURLErrorTimedOut:
			resultString = @"kCFURLErrorTimedOut";
			break;
		case kCFURLErrorUnsupportedURL:
			resultString = @"kCFURLErrorUnsupportedURL";
			break;
		case kCFURLErrorCannotFindHost:
			resultString = @"kCFURLErrorCannotFindHost";
			break;
		case kCFURLErrorCannotConnectToHost:
			resultString = @"kCFURLErrorCannotConnectToHost";
			break;
		case kCFURLErrorNetworkConnectionLost:
			resultString = @"kCFURLErrorNetworkConnectionLost";
			break;
		case kCFURLErrorDNSLookupFailed:
			resultString = @"kCFURLErrorDNSLookupFailed";
			break;
		case kCFURLErrorHTTPTooManyRedirects:
			resultString = @"kCFURLErrorHTTPTooManyRedirects";
			break;
		case kCFURLErrorResourceUnavailable:
			resultString = @"kCFURLErrorResourceUnavailable";
			break;
		case kCFURLErrorNotConnectedToInternet:
			resultString = @"kCFURLErrorNotConnectedToInternet";
			break;
		case kCFURLErrorRedirectToNonExistentLocation:
			resultString = @"kCFURLErrorRedirectToNonExistentLocation";
			break;
		case kCFURLErrorBadServerResponse:
			resultString = @"kCFURLErrorBadServerResponse";
			break;
		case kCFURLErrorUserCancelledAuthentication:
			resultString = @"kCFURLErrorUserCancelledAuthentication";
			break;
		case kCFURLErrorUserAuthenticationRequired:
			resultString = @"kCFURLErrorUserAuthenticationRequired";
			break;
		case kCFURLErrorZeroByteResource:
			resultString = @"kCFURLErrorZeroByteResource";
			break;
		case kCFURLErrorCannotDecodeRawData:
			resultString = @"kCFURLErrorCannotDecodeRawData";
			break;
		case kCFURLErrorCannotDecodeContentData:
			resultString = @"kCFURLErrorCannotDecodeContentData";
			break;
		case kCFURLErrorCannotParseResponse:
			resultString = @"kCFURLErrorCannotParseResponse";
			break;
		case kCFURLErrorInternationalRoamingOff:
			resultString = @"kCFURLErrorInternationalRoamingOff";
			break;
		case kCFURLErrorCallIsActive:
			resultString = @"kCFURLErrorCallIsActive";
			break;
		case kCFURLErrorDataNotAllowed:
			resultString = @"kCFURLErrorDataNotAllowed";
			break;
		case kCFURLErrorRequestBodyStreamExhausted:
			resultString = @"kCFURLErrorRequestBodyStreamExhausted";
			break;
		case kCFURLErrorFileDoesNotExist:
			resultString = @"kCFURLErrorFileDoesNotExist";
			break;
		case kCFURLErrorFileIsDirectory:
			resultString = @"kCFURLErrorFileIsDirectory";
			break;
		case kCFURLErrorNoPermissionsToReadFile:
			resultString = @"kCFURLErrorNoPermissionsToReadFile";
			break;
		case kCFURLErrorDataLengthExceedsMaximum:
			resultString = @"kCFURLErrorDataLengthExceedsMaximum";
			break;
		case kCFURLErrorSecureConnectionFailed:
			resultString = @"kCFURLErrorSecureConnectionFailed";
			break;
		case kCFURLErrorServerCertificateHasBadDate:
			resultString = @"kCFURLErrorServerCertificateHasBadDate";
			break;
		case kCFURLErrorServerCertificateUntrusted:
			resultString = @"kCFURLErrorServerCertificateUntrusted";
			break;
		case kCFURLErrorServerCertificateHasUnknownRoot:
			resultString = @"kCFURLErrorServerCertificateHasUnknownRoot";
			break;
		case kCFURLErrorServerCertificateNotYetValid:
			resultString = @"kCFURLErrorServerCertificateNotYetValid";
			break;
		case kCFURLErrorClientCertificateRejected:
			resultString = @"kCFURLErrorClientCertificateRejected";
			break;
		case kCFURLErrorClientCertificateRequired:
			resultString = @"kCFURLErrorClientCertificateRequired";
			break;
		case kCFURLErrorCannotLoadFromNetwork:
			resultString = @"kCFURLErrorCannotLoadFromNetwork";
			break;
		case kCFURLErrorCannotCreateFile:
			resultString = @"kCFURLErrorCannotCreateFile";
			break;
		case kCFURLErrorCannotOpenFile:
			resultString = @"kCFURLErrorCannotOpenFile";
			break;
		case kCFURLErrorCannotCloseFile:
			resultString = @"kCFURLErrorCannotCloseFile";
			break;
		case kCFURLErrorCannotWriteToFile:
			resultString = @"kCFURLErrorCannotWriteToFile";
			break;
		case kCFURLErrorCannotRemoveFile:
			resultString = @"kCFURLErrorCannotRemoveFile";
			break;
		case kCFURLErrorCannotMoveFile:
			resultString = @"kCFURLErrorCannotMoveFile";
			break;
		case kCFURLErrorDownloadDecodingFailedMidStream:
			resultString = @"kCFURLErrorDownloadDecodingFailedMidStream";
			break;
		case kCFURLErrorDownloadDecodingFailedToComplete:
			resultString = @"kCFURLErrorDownloadDecodingFailedToComplete";
			break;
		case kCFHTTPCookieCannotParseCookieFile:
			resultString = @"kCFHTTPCookieCannotParseCookieFile";
			break;
		case kCFNetServiceErrorUnknown:
			resultString = @"kCFNetServiceErrorUnknown";
			break;
		case kCFNetServiceErrorCollision:
			resultString = @"kCFNetServiceErrorCollision";
			break;
		case kCFNetServiceErrorNotFound:
			resultString = @"kCFNetServiceErrorNotFound";
			break;
		case kCFNetServiceErrorInProgress:
			resultString = @"kCFNetServiceErrorInProgress";
			break;
		case kCFNetServiceErrorBadArgument:
			resultString = @"kCFNetServiceErrorBadArgument";
			break;
		case kCFNetServiceErrorCancel:
			resultString = @"kCFNetServiceErrorCancel";
			break;
		case kCFNetServiceErrorInvalid:
			resultString = @"kCFNetServiceErrorInvalid";
			break;
		case kCFNetServiceErrorTimeout:
			resultString = @"kCFNetServiceErrorTimeout";
			break;
		case kCFNetServiceErrorDNSServiceFailure:
			resultString = @"kCFNetServiceErrorDNSServiceFailure";
			break;
		default:
			resultString = @"Unrecognized Error";
			break;
	}
	
	return resultString;
}


@end

