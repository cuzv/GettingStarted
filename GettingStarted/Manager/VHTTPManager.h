//
//  NIManager.h
//  GettingStarted
//
//  Created by Moch on 8/16/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

// Attention: HttpRequestSerializerTypeXML's serializer is `Unclear` now
typedef NS_ENUM(NSInteger, HTTPRequestSerializerType) {
    HTTPRequestSerializerTypeNone         = 0,
    HTTPRequestSerializerTypeJSON         = 1,
    HTTPRequestSerializerTypePropertyList = 2,
    HTTPRequestSerializerTypeXML          = HTTPRequestSerializerTypePropertyList,
    HTTPRequestSerializerTypeBase64       = 4,
    HTTPRequestSerializerTypeMd5          = 5,
    HTTPRequestSerializerTypeSha1         = 6,
};

typedef NS_ENUM(NSInteger, HTTPResponseSerializerType) {
    HTTPResponseSerializerTypeJSON         = 0,
    HTTPResponseSerializerTypePropertyList = 1,
    HTTPResponseSerializerTypeXMLParser    = 2,
    HTTPResponseSerializerTypeXMLDocument  = 3,
    HTTPResponseSerializerTypeImage        = 4,
    HTTPResponseSerializerTypeCompound     = 5,
    HTTPResponseSerializerTypeNone         = 6
};

// TODO: HTTPFormField should be given from API coder
typedef NS_ENUM(NSInteger, HTTPFormField) {
    HTTPFormFieldPNG,
    HTTPFormFieldBMP,
    HTTPFormFieldAVI,
    HTTPFormFieldMp3,
    HTTPFormFieldTXT,
    HTTPFormFieldHTML,
    HTTPFormFieldXML,
    HTTPFormFieldCER,
    HTTPFormFieldP12
};

// common mine types
typedef NS_ENUM (NSInteger, HTTPMineType) {
    HTTPMineTypePNG,
    HTTPMineTypeBMP,
    HTTPMineTypeAVI,
    HTTPMineTypeMP3,
    HTTPMineTypeTXT,
    HTTPMineTypeHTML,
    HTTPMineTypeXML,
    HTTPMineTypeCER,
    HTTPMineTypeP12
};

typedef NS_ENUM (NSInteger, FileSuffixName) {
    FileSuffixNamePNG,
    FileSuffixNameBMP,
    FileSuffixNameAVI,
    FileSuffixNameMP3,
    FileSuffixNameTXT,
    FileSuffixNameHTML,
    FileSuffixNameXML,
    FileSuffixNameCER,
    FileSuffixNameP12
};

typedef void (^NetowrkPushResultSuccessCompletionHandle)(NSURLSessionDataTask *task, id responseObject);
typedef void (^NetowrkPushResultFailureCompletionHandle)(NSURLSessionDataTask *task, NSError *error);

@interface VHTTPManager : NSObject

// messages
// setting http request serializer type.
// If you wanna encode your request, please call this message in `AppDelegate`.
// The default setting is `HTTPRequestSerializerTypeNone`
+ (void)setHTTPRequestSerializerType:(HTTPRequestSerializerType)requestSerializerType;
+ (HTTPRequestSerializerType)requestSerializerType;

// setting http response serializer type
// If you wanna decode your response, please call this message in `AppDelegate`.
// The default setting is `HTTPResponseSerializerTypeJSON`
+ (void)setHTTPResponseSerializerType:(HTTPResponseSerializerType)responseSerializerType;

// POST
+ (void)POSTWithMethodName:(NSString *)methodName
                parameters:(NSDictionary *)parameters
                   success:(NetowrkPushResultFailureCompletionHandle)success
                   failure:(NetowrkPushResultFailureCompletionHandle)failure;

// POST png
+ (void)POSTPNGWithMethodName:(NSString *)methodName
				   parameters:(NSDictionary *)parameters
					formDatas:(NSArray *)datas
					  success:(NetowrkPushResultFailureCompletionHandle)success
					  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
// POST with data
+ (void)POSTWithMethodName:(NSString *)methodName
                parameters:(NSDictionary *)parameters
                 formDatas:(NSArray *)datas
                 formField:(HTTPFormField)fieldName
                  mineType:(HTTPMineType)mineType
                   success:(NetowrkPushResultFailureCompletionHandle)success
                   failure:(NetowrkPushResultFailureCompletionHandle)failure;

// present progress animation
+ (void)requestWillBeginWithProgressAnimation;

// remove request by method name
+ (void)removeRequestByMthodName:(NSString *)methodName;

// remove lately request
+ (void)removeLatelyRequest;

// remove all request
+ (void)removeAllRequest;


@end
