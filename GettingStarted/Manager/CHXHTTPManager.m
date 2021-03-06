//
//  CHXHTTPManager.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/cuzv).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CHXHTTPManager.h"
#import "AFNetworking.h"
#import "Base64.h"
#import "Hashes.h"
#import "NSObjectExtension.h"
#import "CHXHTTPConfigure.h"
#import "Extension.h"

NSString *CHXHTTPRequestMethodName = @"";

@interface CHXHTTPSessionManager : AFHTTPSessionManager <NSSecureCoding, NSCopying, NSMutableCopying>

// AFNetworking's requestSerializer is almost can not work, service's POST will get POST-VALUE by `CHXHTTPParametersKey`.
// so, we can not encode `CHXHTTPParametersKey`.We just can encode value for key `CHXHTTPParametersKey`. So we encode by ours
// httpRequestSerializerType. Then POST data {`CHXHTTPParametersKey`=ENCODE[value for `CHXHTTPParametersKey`]}.
@property (nonatomic, assign) HTTPRequestSerializerType requestSerializerType;

+ (instancetype)sharedInstance;
+ (BOOL)isNetworkReachable;

@end

@implementation CHXHTTPSessionManager

static CHXHTTPSessionManager *sharedInstance;

#pragma mark -  CHHTTPSessionManager singleton

+ (id)copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    CHXHTTPSessionManager *mutableCopy = [[[self class] allocWithZone:zone] init];
    [[self chx_properties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
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
        NSURL *baseURL = [NSURL URLWithString:[self __httpBaseURL]];
        // Configure Session Configuration
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.allowsCellularAccess       = YES;
        sessionConfiguration.allowsCellularAccess       = YES;
        sessionConfiguration.HTTPShouldSetCookies       = YES;
        sessionConfiguration.timeoutIntervalForRequest  = CHXTimeoutInterval;
        sessionConfiguration.timeoutIntervalForResource = CHXTimeoutInterval;
        sessionConfiguration.HTTPAdditionalHeaders      = CHXHTTPHeaders;
        sessionConfiguration.requestCachePolicy         = NSURLRequestReturnCacheDataElseLoad;
        sessionConfiguration.HTTPCookieStorage          = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        
        sharedInstance = [[CHXHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:sessionConfiguration];
        
        // request serializer. suggest DO NOT use this if your server get post data by $_POST['$CHXHTTPParametersKey']
        //        sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
        
        // response serializer
        AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        jsonResponseSerializer.acceptableContentTypes = [jsonResponseSerializer.acceptableContentTypes setByAddingObject:CHXHTTPContentTypePlain];
        jsonResponseSerializer.acceptableContentTypes = [jsonResponseSerializer.acceptableContentTypes setByAddingObject:        CHXHTTPContentTypeHtml];
        sharedInstance.responseSerializer = jsonResponseSerializer;
        
        // monitoring network status
        [CHXHTTPSessionManager __processNetworkMonitoring];
    });
    
    return sharedInstance;
}

+ (void)__processNetworkMonitoring {
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
    return ![CHXHTTPSessionManager sharedInstance].operationQueue.isSuspended;
}

+ (NSString *)__httpBaseURL {
    NSString *baseURL = nil;
#ifdef DEBUG
    baseURL = CHXHTTPDebugBaseURL;
#else
    baseURL = CHXHTTPRealseBaseURL;
#endif
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

@implementation CHXHTTPManager

static NSMutableArray *sessions;

+ (BOOL)__shouldContinue {
    BOOL shouldContinue = YES;
    if (![CHXHTTPSessionManager isNetworkReachable]) {
        [UIAlertView chx_showAlertWithMessage:CHXHTTPNetworkNotReachable];
        shouldContinue = NO;
    }
    return shouldContinue;
}

// setting http request serializer type
+ (void)setHTTPRequestSerializerType:(HTTPRequestSerializerType)requestSerializerType {
    [CHXHTTPSessionManager sharedInstance].requestSerializerType = requestSerializerType;
}

// getting http request serializer type
+ (HTTPRequestSerializerType)requestSerializerType {
    return [CHXHTTPSessionManager sharedInstance].requestSerializerType;
}

// setting http response serializer type
+ (void)setHTTPResponseSerializerType:(HTTPResponseSerializerType)responseSerializerType {
    AFHTTPResponseSerializer <AFURLResponseSerialization> *responseSerializer = nil;
    
    switch (responseSerializerType) {
        case HTTPResponseSerializerTypeJSON:
            responseSerializer = [AFJSONResponseSerializer serializer];
            responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:CHXHTTPContentTypePlain];
            responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:CHXHTTPContentTypeHtml];
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

+ (NSDictionary *)__encodeParameters:(NSDictionary *)parameters {
    NSString *encodeString = nil;
    /* flow methods is not encode `CHXHTTPParametersKey` */
    switch ([CHXHTTPSessionManager sharedInstance].requestSerializerType) {
        case HTTPRequestSerializerTypeNone:
            encodeString = [parameters chx_URLParameterString];
            break;
        case HTTPRequestSerializerTypeJSON: {
            // convert parameters to JSON string
            NSData *JSONData = [NSData chx_dataWithJSONObject:parameters];
            encodeString =  [JSONData chx_UTF8String];
        }
            break;
        case HTTPRequestSerializerTypePropertyList:{
            NSData *propertyListData = [NSData chx_dataWithPropertyList:parameters];
            encodeString = [propertyListData chx_UTF8String];
        }
            break;
        case HTTPRequestSerializerTypeBase64: {
            // base64
            NSString *URLString = [parameters chx_URLParameterString];
            encodeString = [URLString base64EncodedString];
        }
            break;
        case HTTPRequestSerializerTypeMd5:{
            // md5
            NSString *URLString = [parameters chx_URLParameterString];
            encodeString = [URLString md5];
        }
            break;
        case HTTPRequestSerializerTypeSha1: {
            // sha1
            NSString *URLString = [parameters chx_URLParameterString];
            encodeString = [URLString sha1];
        }
        default:
            break;
    }
    
    return @{CHXHTTPParametersKey:encodeString};
}

#pragma mark - HTTP requst messages

+ (void)removeRequestByMthodName:(NSString *)methodName {
    // record current http request method name, when `BaseViewController` disappear will use this variable
    CHXHTTPRequestMethodName = methodName;
    
    if (!methodName.length) {
        return;
    }
    NSURL *wantRequestURL = [[CHXHTTPSessionManager sharedInstance].baseURL URLByAppendingPathComponent:methodName];
    for (NSURLSessionTask *task in [CHXHTTPSessionManager sharedInstance].tasks) {
        if ([wantRequestURL isEqual:task.currentRequest.URL]) {
            [task cancel];
            break;
        }
    }
    [self requestDidEnd];
}

+ (void)removeLatelyRequest {
    [self removeRequestByMthodName:CHXHTTPRequestMethodName];
}

+ (void)removeAllRequest {
    [[CHXHTTPSessionManager sharedInstance].tasks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj cancel];
    }];
}

+ (void)requestWillBeginWithProgressAnimation {
    [[[[UIApplication sharedApplication] windows] lastObject] chx_addGradientCircularProgressAnimation];
}

+ (void)requestWillBegin {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void)requestDidEnd {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [[[[UIApplication sharedApplication] windows] lastObject] chx_removeGradientCircularProgressAnimation];
    CHXHTTPRequestMethodName = @"";
}

// 后台接收哪种格式的参数，传递参数的时候就发什么格式的过去，「团队宝」后台需要的是 base64，所以不用 AFNetworking 的 AFJSONRequestSerializer 转换器
// POST
+ (void)POSTWithMethodName:(NSString *)methodName
                parameters:(NSDictionary *)parameters
                   success:(NetowrkPushResultFailureCompletionHandle)success
                   failure:(NetowrkPushResultFailureCompletionHandle)failure {
    if (![CHXHTTPManager __shouldContinue]) {
        return;
    }
    // remove same request
    [self removeRequestByMthodName:methodName];
    [self requestWillBegin];
    NSDictionary *encodeParameters = [self __encodeParameters:parameters];
    [[CHXHTTPSessionManager sharedInstance] POST:methodName
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
    if (![CHXHTTPManager __shouldContinue]) {
        return;
    }
    
    // remove same request
    [self removeRequestByMthodName:methodName];
    
    [self requestWillBegin];
    NSDictionary *encodeParameters = [self __encodeParameters:parameters];
    
    [[CHXHTTPSessionManager sharedInstance] POST:methodName
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
