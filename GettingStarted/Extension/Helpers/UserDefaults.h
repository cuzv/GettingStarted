//
//  UserDefaults.h
//  GettingStarted
//
//  Created by Moch on 11/13/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

/**
 *  保存值到 NSUserDefaults
 *
 *  @param value 值
 *  @param key   键
 */
- (void)setValue:(id)value forKey:(NSString *)key;

/**
 *  通过键获取值
 *
 *  @param key 键
 *
 *  @return 值
 */
- (id)valueForKey:(NSString *)key;


/**
 *  保存布尔值到 NSUserDefaults
 *
 *  @param value       布尔值
 *  @param defaultName 键
 */
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

/**
 *  通过键获取布尔值
 *
 *  @param defaultName 键
 *
 *  @return 布尔值
 */
- (BOOL)boolForKey:(NSString *)defaultName;

/**
 *  打印保存的所有信息
 */
- (void)echo;

@end
