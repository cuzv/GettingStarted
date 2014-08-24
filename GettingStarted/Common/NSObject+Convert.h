//
//  NSObject+Convert.h
//  GettingStarted
//
//  Created by Moch on 14-5-26.
//  Copyright (c) 2014年 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Convert)

// 快速创建模型
- (instancetype)initWithProperties:(NSDictionary *)properties;

// 获取属性列表
- (NSMutableArray *)properties;
+ (NSMutableArray *)properties;

// 自身对象转为字典
- (NSDictionary *)convertToDictionary;

// 打印对象
- (NSMutableString *)toString;

@end
