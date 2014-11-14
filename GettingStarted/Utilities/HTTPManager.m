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
#import "NSObjectCategories.h"
#import "NIConstant.h"
#import "AppMacro.h"
#import "UIViewCategories.h"

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
        [UIView toastWithMessage:CHNetworkNotReachable];
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

// convert dictionary to url string
+ (NSString *)URLStringWithParameters:(NSDictionary *)paramDictionary {
    NSAssert([paramDictionary isKindOfClass:[paramDictionary class]],
             @"The input parameters is not dictionary type!");
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithDictionary:paramDictionary];
    NSMutableString *URLParamMutableString = [NSMutableString new];
    [paramDic keysOfEntriesWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id key, id obj, BOOL *stop) {
        [URLParamMutableString appendFormat:@"%@=%@&", key, obj];
        return NO;
    }];
    NSString *URLParamString = [URLParamMutableString substringToIndex:URLParamMutableString.length - 1];

    return URLParamString;
}

// create UTF8 string by ISO string
+ (NSString *)UTF8StringWithISOString:(NSString *)string {
    NSAssert([string isKindOfClass:[NSString class]],
             @"The input parameters is not string type!");
    
    NSStringEncoding UTF8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSStringEncoding ISOEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSData *ISOData = [string dataUsingEncoding:ISOEncoding];
    NSString *UTF8String = [[NSString alloc] initWithData:ISOData encoding:UTF8Encoding];
    return UTF8String;
}

// Create a Foundation object from JSON data
+ (id)JSONObjectWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableLeaves
                                                  error:&error];
    if (error) {
        NSLog(@"Deserialized JSON string failed with error message '%@'.",
              [error localizedDescription]);
    }
    
    return object;
}

// Generate JSON data from a Foundation object
+ (NSData *)dataWithJSONObject:(id)object {
    if (!object) {
        return nil;
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if (error) {
        NSLog(@"Serialized JSON string failed with error message '%@'.",
              [error localizedDescription]);
    }
    return data;
}

// Generate string from data
+ (NSString *)stringWithData:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

// Create an NSData from a property list.
+ (NSData *)dataWithPropertyList:(id)plist {
    NSError *error = nil;
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:plist
                                                              format:NSPropertyListXMLFormat_v1_0 options:0
                                                               error:&error];
    if (error) {
        NSLog(@"Serialized PropertyList string failed with error message '%@'.",
              [error localizedDescription]);
    }
    return data;
}

+ (NSDictionary *)encodeParameters:(NSDictionary *)parameters {
    NSString *encodeString = nil;
    /* flow methods is not encode `CHParametersKey` */
    switch ([CHHTTPSessionManager sharedInstance].requestSerializerType) {
        case HTTPRequestSerializerTypeNone:
            encodeString = [self URLStringWithParameters:parameters];
            break;
        case HTTPRequestSerializerTypeJSON: {
            // convert parameters to JSON string
            NSData *JSONData = [self dataWithJSONObject:parameters];
            encodeString = [self stringWithData:JSONData];
        }
            break;
        case HTTPRequestSerializerTypePropertyList:{
            NSData *propertyListData = [self dataWithPropertyList:parameters];
            encodeString = [self stringWithData:propertyListData];
        }
            break;
        case HTTPRequestSerializerTypeBase64: {
            // base64
            NSString *URLString = [self URLStringWithParameters:parameters];
            encodeString = [URLString base64EncodedString];
        }
            break;
        case HTTPRequestSerializerTypeMd5:{
            // md5
            NSString *URLString = [self URLStringWithParameters:parameters];
            encodeString = [URLString md5];
        }
            break;
        case HTTPRequestSerializerTypeSha1: {
            // sha1
            NSString *URLString = [self URLStringWithParameters:parameters];
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
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
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
					  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
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
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
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
