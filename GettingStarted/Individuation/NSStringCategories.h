//
//  NSStringCategories.h
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSStringCategories : NSObject
@end

#pragma mark - 计算字符串所占空间尺寸大小

@interface NSString (TextSize)

/**
 *  根据字体获取所占空间尺寸大小
 *
 *  @param font 字体
 *
 *  @return 尺寸大小
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  根据字体获取所占空间尺寸大小
 *
 *  @param font  字体
 *  @param width 最大宽度
 *
 *  @return 尺寸大小
 */
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width;

@end


#pragma mark - 正则验证

@interface NSString (Verification)

/**
 *  是否为合法邮箱地址
 *
 *  @param email 邮箱地址字符串
 *
 *  @return 是否合法
 */
+ (BOOL)isValidEmail:(NSString *)email;

/**
 *  是否为合法手机号码
 *
 *  @param phoneNumber 手机号码
 *
 *  @return 是否合法
 */
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber;

/**
 *  是否为合法密码
 *
 *  @param password 密码
 *
 *  @return 是否合法
 */
+ (BOOL)isValidPassword:(NSString *)password;

/**
 *  是否为合法验证码
 *
 *  @param authCode 验证码
 *
 *  @return 是否合法
 */
+ (BOOL)isvalidAuthCode:(NSString *)authCode;

/**
 *  是否为空
 *
 *  @return 是否为空
 */
- (BOOL)isEmpty;

/**
 *  去除两头空白
 *
 *  @return 两头无空白的字符串
 */
- (NSString *)trim;

@end


#pragma mark - 获取路径

@interface NSString (SearchPath)

/**
 *  获取文档目录
 *
 *  @return 文档目录
 */
+ (NSString *)documentDirectory;

/**
 *  获取缓存目录
 *
 *  @return 缓存目录
 */
+ (NSString *)cachesDirectory;

/**
 *  获取下载目录
 *
 *  @return 下载目录
 */
+ (NSString *)downloadsDirectory;

/**
 *  获取电影目录
 *
 *  @return 电影目录
 */
+ (NSString *)moviesDirectory;

/**
 *  获取音乐目录
 *
 *  @return 音乐目录
 */
+ (NSString *)musicDirectory;

/**
 *  获取图片目录
 *
 *  @return 图片目录
 */
+ (NSString *)picturesDirectory;

@end
