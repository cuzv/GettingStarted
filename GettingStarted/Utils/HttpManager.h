//
//  NIManager.h
//  GettingStarted
//
//  Created by Moch on 8/16/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

// Attention: HttpRequestSerializerTypeXML's serializer is `Unclear` now
typedef NS_ENUM(NSInteger, HttpRequestSerializerType) {
    HttpRequestSerializerTypeNone         = 0,
    HttpRequestSerializerTypeJSON         = 1,
    HttpRequestSerializerTypePropertyList = 2,
    HttpRequestSerializerTypeXML          = HttpRequestSerializerTypePropertyList,
    HttpRequestSerializerTypeBase64       = 4,
    HttpRequestSerializerTypeMd5          = 5,
    HttpRequestSerializerTypeSha1         = 6,
};

typedef NS_ENUM(NSInteger, HttpResponseSerializerType) {
    HttpResponseSerializerTypeJSON         = 0,
    HttpResponseSerializerTypePropertyList = 1,
    HttpResponseSerializerTypeXMLParser    = 2,
    HttpResponseSerializerTypeXMLDocument  = 3,
    HttpResponseSerializerTypeImage        = 4,
    HttpResponseSerializerTypeCompound     = 5,
    HttpResponseSerializerTypeNone         = 6
};

@interface HttpManager : NSObject

// messages
// setting http request serializer type.
// If you wanna encode your request, please call this message in `AppDelegate`.
// The default setting is `HttpRequestSerializerTypeNone`
+ (void)setHttpRequestSerializerType:(HttpRequestSerializerType)httpRequestSerializerType;
+ (HttpRequestSerializerType)requestSerializerType;
// setting http response serializer type
// If you wanna decode your response, please call this message in `AppDelegate`.
// The default setting is `HttpResponseSerializerTypeJSON`
+ (void)setHttpResponseSerializerType:(HttpResponseSerializerType)httpResponseSerializerType;

// POST
+ (void)POSTWithMethodName:(NSString *)methodName
                parameters:(NSDictionary *)parameters
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
// POST with data
+ (void)POSTWithMethodName:(NSString *)methodName
                parameters:(NSDictionary *)parameters
                  passData:(NSData *)data
                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
