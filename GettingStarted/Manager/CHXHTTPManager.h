//
//  CHXHTTPManager.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
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

@interface CHXHTTPManager : NSObject

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
