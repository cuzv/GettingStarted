//
//  CHXRequest.h
//  GettingStarted
//
//  Created by Moch Xiao on 11/30/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

// HTTP Method
typedef NS_ENUM(NSInteger, CHXRequestMethod) {
	CHXRequestMethodPost = 0,
	CHXRequestMethodGet,
	CHXRequestMethodPut,
	CHXRequestMethodDelete,
	CHXRequestMethodPatch,
	CHXRequestMethodHead,
	CHXRequestMethodNone
};

typedef NS_ENUM(NSInteger, CHXRequestSerializerType) {
	CHXRequestSerializerTypeJSON         = 0,
	CHXRequestSerializerTypePropertyList,
	CHXRequestSerializerTypeXML          = CHXRequestSerializerTypePropertyList,
	CHXRequestSerializerTypeBase64,
	CHXRequestSerializerTypeMd5,
	CHXRequestSerializerTypeSha1,
	CHXRequestSerializerTypeNone
};

typedef NS_ENUM(NSInteger, CHXResponseSerializerType) {
	CHXResponseSerializerTypeJSON = 0,
	CHXResponseSerializerTypePropertyList,
	CHXResponseSerializerTypeXMLParser,
	CHXResponseSerializerTypeXMLDocument,
	CHXResponseSerializerTypeImage,
	CHXResponseSerializerTypeCompound,
	CHXResponseSerializerTypeNone
};

#pragma mark -

typedef void(^RequestSuccessCompletionBlock)(id responseData);
typedef void(^RequestFailureCompletionBlock)(id errorMessage);
typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);

#pragma mark -

// This class collection a request infos what needed, by subclass and override methods
@interface CHXRequest : NSObject


#pragma mark - Subclass should overwrite thoese methods

#pragma mark - Collect request infos

/**
 *  组装请求参数
 *
 *  @return AF 请求参数
 */
- (NSDictionary *)requestParameters;

/**
 *  请求公共 URL 字符串
 *
 *  @return 请求公共 URL 字符串
 */
- (NSString *)requestBaseURLString;

/**
 *  请求特有 URL 字符串
 *
 *  @return 请求特有 URL 字符串
 */
- (NSString *)requestSpecificURLString;

/**
 *  请求方式
 *
 *  @return 请求方式
 */
- (CHXRequestMethod)requestMehtod;

/**
 *  请求参数序列化类型
 *
 *  @return 序列化器类型
 */
- (CHXRequestSerializerType)requestSerializerType;

/**
 *  POST 数据提交 Block
 *
 *  @return POST 数据提交 Block
 */
- (AFConstructingBlock)constructingBodyBlock;

/**
 *  请求超时时长
 *
 *  @return 请求超时时长
 */
- (NSTimeInterval)requestTimeoutInterval;

/**
 *  是否需要缓存
 *
 *  @return Default value is YES
 */
- (BOOL)requestNeedCache;

/**
 *  缓存时长
 *
 *  @return 缓存时长
 */
- (NSTimeInterval)requestCacheDuration;

#pragma mark - Collect response infos

/**
 *  请求回送数据反序列化器类型
 *
 *  @return 请求回送数据反序列化器类型
 */
- (CHXResponseSerializerType)responseSerializerType;

/**
 *  回送数据接口 API 字段名称
 *
 *  @return 回送数据接口 API 字段名称
 */
- (NSString *)responseApiVersionFieldName;

/**
 *  回送数据接口 回送主要数据 字段名称
 *
 *  @return 回送数据接口 回送主要数据 字段名称
 */
- (NSString *)responseDataFieldName;

/**
 *  回送数据接口 响应编码 字段名称
 *
 *  @return 回送数据接口 响应编码 字段名称
 */
- (NSString *)responseCodeFieldName;

/**
 *  回送数据接口 响应消息 字段名称
 *
 *  @return 回送数据接口 响应消息 字段名称
 */
- (NSString *)responseMessageFieldName;

#pragma mark - Request

/**
 *  请求成功回调
 */
@property (nonatomic, copy) RequestSuccessCompletionBlock requestSuccessCompletionBlock;

/**
 *  请求失败回调
 */
@property (nonatomic, copy) RequestFailureCompletionBlock requestFailureCompletionBlock;

/**
 *  开始发起请求
 */
- (void)startRequest;

/**
 *  开始发起请求
 *
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
- (void)startRequestWithSuccess:(RequestSuccessCompletionBlock)success failue:(RequestFailureCompletionBlock)failure;


@property (nonatomic, strong) NSURLSessionTask *requestSessionTask;

@end