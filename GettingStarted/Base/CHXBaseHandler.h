//
//  CHXBaseHandler.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-10.
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
