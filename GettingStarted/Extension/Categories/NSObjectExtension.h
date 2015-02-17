//
//  NSObjectExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-26.
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

@interface NSObjectExtension : NSObject

@end


#pragma mark - 对象模型与原生类型间的转换

@interface NSObject (CHXConvert)

/**
 *  快速创建模型
 *
 *  @param properties 属性字典
 *
 *  @return 对象实例
 */
- (instancetype)chx_initWithProperties:(NSDictionary *)properties NS_REPLACES_RECEIVER;

/**
 *  获取属性列表
 *
 *  @return 属性列表
 */
- (NSArray *)chx_properties;

/**
 *  获取属性列表
 *
 *  @return 属性列表
 */
+ (NSArray *)chx_properties;

/**
 *  获取方法列表
 *
 *  @return 方法列表
 */
- (NSArray *)chx_methods;

/**
 *  获取方法列表
 *
 *  @return 方法列表
 */
+ (NSArray *)chx_methods;

/**
 *  自身对象转为字典
 *
 *  @return 自身属性打包的字典
 */
- (NSDictionary *)chx_convertToDictionary;

/**
 *  打印对象
 *
 *  @return 对象描述字符串
 */
- (NSString *)chx_toString;

@end




