//
//  CHXBaseHandler.h
//  GettingStarted
//
//  Created by Moch Xiao on 12/10/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CHXBaseRequest;

typedef void(^HandlerSuccessCompletionBlock)(id modelObject);
typedef void(^HandlerFailureCompletionBlock)(id errorMessage);

@interface CHXBaseHandler : NSObject

/**
 *  网络请求逻辑业务处理层，由子类复写，调用者为 controller 
 *
 *  @param request 请求对象
 *  @param success 请求成功回调，一般在这里处服务器理返回的数据，回传给上层调用者。回传数据一般为模型数据或者模型数据集合
 *  @param failure 请求失败回调，一般回传错误信息
 */
+ (void)handleRequest:(CHXBaseRequest *)request withSuccess:(HandlerSuccessCompletionBlock)success failure:(HandlerFailureCompletionBlock)failure;

@end
