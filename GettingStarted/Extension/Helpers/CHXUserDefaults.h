//
//  CHXUserDefaults.h
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

@interface CHXUserDefaults : NSObject

/**
 *  保存值到 NSUserDefaults
 *
 *  @param value 值
 *  @param key   键
 */
+ (void)setValue:(id)value forKey:(NSString *)key;

/**
 *  通过键获取值
 *
 *  @param key 键
 *
 *  @return 值
 */
+ (id)valueForKey:(NSString *)key;


/**
 *  保存布尔值到 NSUserDefaults
 *
 *  @param value       布尔值
 *  @param defaultName 键
 */
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

/**
 *  通过键获取布尔值
 *
 *  @param defaultName 键
 *
 *  @return 布尔值
 */
+ (BOOL)boolForKey:(NSString *)defaultName;

/**
 *  打印保存的所有信息
 */
+ (void)echo;

@end
