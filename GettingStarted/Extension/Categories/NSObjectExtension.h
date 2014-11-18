//
//  NSObjectExtension.h
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObjectExtension : NSObject

@end


#pragma mark - 对象模型与原生类型间的转换

@interface NSObject (Convert)

/**
 *  快速创建模型
 *
 *  @param properties 属性字典
 *
 *  @return 对象实例
 */
- (instancetype)initWithProperties:(NSDictionary *)properties;

/**
 *  获取属性列表
 *
 *  @return 属性列表
 */
- (NSArray *)properties;

/**
 *  获取属性列表
 *
 *  @return 属性列表
 */
+ (NSArray *)properties;

/**
 *  自身对象转为字典
 *
 *  @return 自身属性打包的字典
 */
- (NSDictionary *)convertToDictionary;

/**
 *  打印对象
 *
 *  @return 对象描述字符串
 */
- (NSString *)toString;

@end
