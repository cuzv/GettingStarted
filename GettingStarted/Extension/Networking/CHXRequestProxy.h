//
//  CHXRequestProxy.h
//  GettingStarted
//
//  Created by Moch Xiao on 12/2/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

@class CHXRequest;

@interface CHXRequestProxy : NSObject

+ (instancetype)sharedInstance;

/**
 *  添加请求任务
 *
 *  @param request 请求任务
 */
- (void)addRequest:(CHXRequest *)request;

/**
 *  取消请求任务
 *
 *  @param request 需要被取消的请求任务
 */
- (void)cancelRequest:(CHXRequest *)request;

/**
 *  取消所有请求任务
 */
- (void)cancelAllRequest;

@end



