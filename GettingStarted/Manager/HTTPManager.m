//
//  NIManager.m
//  GettingStarted
//
//  Created by Moch on 8/16/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "HTTPManager.h"
#import "AFNetworking.h"
#import "Base64.h"
#import "Hashes.h"
#import "NSObjectExtension.h"
#import "HttpConfigure.h"
#import "Extension.h"

NSString *CHHTTPRequestMethodName = @"";

@interface CHHTTPSessionManager : AFHTTPSessionManager <NSSecureCoding, NSCopying, NSMutableCopying>

// AFNetworking's requestSerializer is almost can not work, service's POST will get POST-VALUE by `CHParametersKey`.
// so, we can not encode `CHParametersKey`.We just can encode value for key `CHParametersKey`. So we encode by ours
// httpRequestSerializerType. Then POST data {`CHParametersKey`=ENCODE[value for `CHParametersKey`]}.
@property (nonatomic, assign) HTTPRequestSerializerType requestSerializerType;

+ (instancetype)sharedInstance;
+ (BOOL)isNetworkReachable;

@end

@implementation CHHTTPSessionManager

static CHHTTPSessionManager *sharedInstance;

#pragma mark -  CHHTTPSessionManager singleton

+ (id)copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    CHHTTPSessionManager *mutableCopy = [[[self class] allocWithZone:zone] init];
    [[self properties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [mutableCopy setValue:[self valueForKey:obj] forKey:obj];
    }];
    
    return mutableCopy;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // setting request base URL
        NSURL *baseURL = [NSURL URLWithString:[self httpBaseURL]];
        // Configure Session Configuration
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.allowsCellularAccess       = YES;
        sessionConfiguration.allowsCellularAccess       = YES;
        sessionConfiguration.HTTPShouldSetCookies       = YES;
        sessionConfiguration.timeoutIntervalForRequest  = CHTimeoutInterval;
        sessionConfiguration.timeoutIntervalForResource = CHTimeoutInterval;
        sessionConfiguration.HTTPAdditionalHeaders      = CHHttpHeaders;
        sessionConfiguration.requestCachePolicy         = NSURLRequestReturnCacheDataElseLoad;
        sessionConfiguration.HTTPCookieStorage          = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        
        sharedInstance = [[CHHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:sessionConfiguration];
        
        // request serializer. suggest DO NOT use this if your server get post data by $_POST['$CHParametersKey']
//        sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
        
        // response serializer
        AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        jsonResponseSerializer.acceptableContentTypes = [jsonResponseSerializer.acceptableContentTypes setByAddingObject:CHHttpContentTypePlain];
        jsonResponseSerializer.acceptableContentTypes = [jsonResponseSerializer.acceptableContentTypes setByAddingObject:        CHHttpContentTypeHtml];
        sharedInstance.responseSerializer = jsonResponseSerializer;
        
        // monitoring network status
        [CHHTTPSessionManager processNetworkMonitoring];
    });

    return sharedInstance;
}

+ (void)processNetworkMonitoring {
    AFNetworkReachabilityManager *afNetworkReachabilityManager =  sharedInstance.reachabilityManager;
    NSOperationQueue *operationQueue = sharedInstance.operationQueue;
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [afNetworkReachabilityManager startMonitoring];
}

+ (BOOL)isNetworkReachable {
    return ![CHHTTPSessionManager sharedInstance].operationQueue.isSuspended;
}

+ (NSString *)httpBaseURL {
    NSString *baseURL = nil;
    if (DEBUG) {
        baseURL = CHDebugHttpBaseURL;
    } else {
        baseURL = CHRealseHttpBaseURL;
    }
    return baseURL;
}

@end

#pragma mark -
#pragma mark - HttpManager

const NSString *HTTPFormFieldMapping[] = {
    // TODO: Flow string values should be given from API coder
    [HTTPFormFieldPNG]  = @"png",
    [HTTPFormFieldBMP]  = @"bmp",
    [HTTPFormFieldMp3]  = @"mp3",
    [HTTPFormFieldAVI]  = @"avi",
    [HTTPFormFieldTXT]  = @"txt",
    [HTTPFormFieldHTML] = @"html",
    [HTTPFormFieldXML]  = @"xml",
    [HTTPFormFieldCER]  = @"cer",
    [HTTPFormFieldP12]  = @"p12"
};

const NSString *HTTPMineTypeMapping[] = {
    [HTTPMineTypePNG]  = @"image/png",
    [HTTPMineTypeBMP]  = @"application/x-bmp",
    [HTTPMineTypeAVI]  = @"video/avi",
    [HTTPMineTypeMP3]  = @"audio/mp3",
    [HTTPMineTypeTXT]  = @"text/plain",
    [HTTPMineTypeHTML] = @"text/html",
    [HTTPMineTypeXML]  = @"text/xml",
    [HTTPMineTypeCER]  = @"application/x-x509-ca-cert",
    [HTTPMineTypeP12]  = @"application/x-pkcs12"
};

const NSString *FileSuffixNameMapping[] = {
    [FileSuffixNamePNG]  = @"png",
    [FileSuffixNameBMP]  = @"bmp",
    [FileSuffixNameAVI]  = @"avi",
    [FileSuffixNameMP3]  = @"mp3",
    [FileSuffixNameTXT]  = @"txt",
    [FileSuffixNameHTML] = @"html",
    [FileSuffixNameXML]  = @"xml",
    [FileSuffixNameCER]  = @"xml",
    [FileSuffixNameP12]  = @"p12"
};

@implementation HTTPManager

static NSMutableArray *sessions;

+ (BOOL)shouldContinue {
    BOOL shouldContinue = YES;
    if (![CHHTTPSessionManager isNetworkReachable]) {
		[UIAlertView showAlertWithMessage:CHNetworkNotReachable];
        shouldContinue = NO;
    }
    return shouldContinue;
}

// setting http request serializer type
+ (void)setHTTPRequestSerializerType:(HTTPRequestSerializerType)requestSerializerType {
    [CHHTTPSessionManager sharedInstance].requestSerializerType = requestSerializerType;
}

// getting http request serializer type
+ (HTTPRequestSerializerType)requestSerializerType {
    return [CHHTTPSessionManager sharedInstance].requestSerializerType;
}

// setting http response serializer type
+ (void)setHTTPResponseSerializerType:(HTTPResponseSerializerType)responseSerializerType {
    AFHTTPResponseSerializer <AFURLResponseSerialization> *responseSerializer = nil;
    
    switch (responseSerializerType) {
        case HTTPResponseSerializerTypeJSON:
            responseSerializer = [AFJSONResponseSerializer serializer];
            responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:CHHttpContentTypePlain];
            responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:CHHttpContentTypeHtml];
            break;
         case HTTPResponseSerializerTypePropertyList:
            responseSerializer = [AFPropertyListResponseSerializer serializer];
            break;
        case HTTPResponseSerializerTypeXMLParser:
            responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
        case HttpResponseSerializerTypeXMLDocument:
            responseSerializer = [AFXMLDocumentResponseSerializer serializer];
            break;
#endif
        case HTTPResponseSerializerTypeImage:
            responseSerializer = [AFImageResponseSerializer serializer];
            break;
        case HTTPResponseSerializerTypeCompound:
            responseSerializer = [AFCompoundResponseSerializer serializer];
            break;
        default:
            responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
    }
    
    sharedInstance.responseSerializer = responseSerializer;
}

#pragma mark - encode messages

+ (NSDictionary *)encodeParameters:(NSDictionary *)parameters {
    NSString *encodeString = nil;
    /* flow methods is not encode `CHParametersKey` */
    switch ([CHHTTPSessionManager sharedInstance].requestSerializerType) {
        case HTTPRequestSerializerTypeNone:
			encodeString = [parameters URLParameterString];
            break;
        case HTTPRequestSerializerTypeJSON: {
            // convert parameters to JSON string
			NSData *JSONData = [NSData dataWithJSONObject:parameters];
			encodeString =  [JSONData UTF8String];
        }
            break;
        case HTTPRequestSerializerTypePropertyList:{
            NSData *propertyListData = [NSData dataWithPropertyList:parameters];
            encodeString = [propertyListData UTF8String];
        }
            break;
        case HTTPRequestSerializerTypeBase64: {
            // base64
            NSString *URLString = [parameters URLParameterString];
            encodeString = [URLString base64EncodedString];
        }
            break;
        case HTTPRequestSerializerTypeMd5:{
            // md5
            NSString *URLString = [parameters URLParameterString];
            encodeString = [URLString md5];
        }
            break;
        case HTTPRequestSerializerTypeSha1: {
            // sha1
            NSString *URLString = [parameters URLParameterString];
            encodeString = [URLString sha1];
        }
        default:
            break;
    }

    return @{CHParametersKey:encodeString};
}

#pragma mark - HTTP requst messages

+ (void)removeRequestByMthodName:(NSString *)methodName {
    // record current http request method name, when `BaseViewController` disappear will use this variable
    CHHTTPRequestMethodName = methodName;
    
    if (!methodName.length) {
        return;
    }
    NSURL *wantRequestURL = [[CHHTTPSessionManager sharedInstance].baseURL URLByAppendingPathComponent:methodName];
    for (NSURLSessionTask *task in [CHHTTPSessionManager sharedInstance].tasks) {
        if ([wantRequestURL isEqual:task.currentRequest.URL]) {
            [task cancel];
            break;
        }
    }
    [self requestDidEnd];
}

+ (void)removeLatelyRequest {
    [self removeRequestByMthodName:CHHTTPRequestMethodName];
}

+ (void)removeAllRequest {
    [[CHHTTPSessionManager sharedInstance].tasks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj cancel];
    }];
}

+ (void)requestWillBeginWithProgressAnimation {
    [[[[UIApplication sharedApplication] windows] lastObject] addGradientCircularProgressAnimation];
}

+ (void)requestWillBegin {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void)requestDidEnd {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [[[[UIApplication sharedApplication] windows] lastObject] removeGradientCircularProgressAnimation];
    CHHTTPRequestMethodName = @"";
}

// 后台接收哪种格式的参数，传递参数的时候就发什么格式的过去，「团队宝」后台需要的是 base64，所以不用 AFNetworking 的 AFJSONRequestSerializer 转换器
// POST
+ (void)POSTWithMethodName:(NSString *)methodName
				parameters:(NSDictionary *)parameters
				   success:(NetowrkPushResultFailureCompletionHandle)success
				   failure:(NetowrkPushResultFailureCompletionHandle)failure {
    if (![HTTPManager shouldContinue]) {
        return;
    }
    // remove same request
    [self removeRequestByMthodName:methodName];
    [self requestWillBegin];
    NSDictionary *encodeParameters = [self encodeParameters:parameters];
    [[CHHTTPSessionManager sharedInstance] POST:methodName
                                     parameters:encodeParameters
                                        success:^(NSURLSessionDataTask *task, id responseObject) {
                                            [self requestDidEnd];
                                            success(task, responseObject);
                                        }
                                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                                            [self requestDidEnd];
                                            failure(task, error);
                                        }];
}

+ (void)POSTPNGWithMethodName:(NSString *)methodName
				   parameters:(NSDictionary *)parameters
					formDatas:(NSArray *)datas
					  success:(NetowrkPushResultFailureCompletionHandle)success
					  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
	[self POSTWithMethodName:methodName
				  parameters:parameters
				   formDatas:datas
				   formField:HTTPFormFieldPNG
					mineType:HTTPMineTypePNG
					 success:success
					 failure:failure];
}

// POST with data
+ (void)POSTWithMethodName:(NSString *)methodName
				parameters:(NSDictionary *)parameters
				 formDatas:(NSArray *)datas
				 formField:(HTTPFormField)fieldName
				  mineType:(HTTPMineType)mineType
				   success:(NetowrkPushResultFailureCompletionHandle)success
				   failure:(NetowrkPushResultFailureCompletionHandle)failure {
    if (![HTTPManager shouldContinue]) {
        return;
    }
	
    // remove same request
    [self removeRequestByMthodName:methodName];
    
    [self requestWillBegin];
    NSDictionary *encodeParameters = [self encodeParameters:parameters];

    [[CHHTTPSessionManager sharedInstance] POST:methodName
                                     parameters:encodeParameters
                      constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                          for (NSData *data in datas) {
                              NSString *formFieldName = (NSString *)HTTPFormFieldMapping[fieldName];
                              NSString *suffixName = (NSString *)FileSuffixNameMapping[mineType];
                              NSString *fileNameWithSuffix = [[[[NSUUID UUID] UUIDString] stringByAppendingString:@"."] stringByAppendingString:suffixName];
                              NSString *contentType = (NSString *)HTTPMineTypeMapping[mineType];
                              [formData appendPartWithFileData:data name:formFieldName fileName:fileNameWithSuffix mimeType:contentType];
                          }
                    }
                                        success:^(NSURLSessionDataTask *task, id responseObject) {
                                            [self requestDidEnd];
                                            success(task, responseObject);
                                        }
                                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                                            [self requestDidEnd];
                                            failure(task, error);
                                        }];
    
}



@end
