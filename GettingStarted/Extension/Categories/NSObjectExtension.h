//
//  NSObjectExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/29/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
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




