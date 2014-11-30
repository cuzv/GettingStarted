//
//  NSStringExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/24/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSStringExtension : NSObject
@end

#pragma mark - 计算字符串所占空间尺寸大小

@interface NSString (CHXTextSize)

/**
 *  根据字体获取所占空间尺寸大小
 *
 *  @param font 字体
 *
 *  @return 尺寸大小
 */
- (CGSize)chx_sizeWithFont:(UIFont *)font;

/**
 *  根据字体获取所占空间尺寸大小
 *
 *  @param font  字体
 *  @param width 最大宽度
 *
 *  @return 尺寸大小
 */
- (CGSize)chx_sizeWithFont:(UIFont *)font width:(CGFloat)width;

@end


#pragma mark - 正则验证

@interface NSString (CHXVerification)

/**
 *  匹配正则表达式
 *
 *  @param regex 正则表达式
 *
 *  @return 是否匹配
 */
- (BOOL)chx_isMatchRegex:(NSString *)regex;

/**
 *  是否为合法邮箱地址
 *
 *  @return 是否合法
 */
- (BOOL)chx_isValidEmail;

/**
 *  是否为合法手机号码
 *
 *  @return 是否合法
 */
- (BOOL)chx_isValidPhoneNumber;

/**
 *  是否为合法密码
 *
 *  @return 是否合法
 */
- (BOOL)chx_isValidPassword;

/**
 *  是否为合法验证码
 *
 *  @param authCode 验证码
 *
 *  @return 是否合法
 */
- (BOOL)chx_isvalidAuthCode;

/**
 *  是否为空
 *
 *  @return 是否为空
 */
- (BOOL)chx_isEmpty;

/**
 *  去除两头空白
 *
 *  @return 两头无空白的字符串
 */
- (NSString *)chx_trim;


@end

#pragma mark - 

@interface NSString (CHXEncoding)

/**
 *  Create UTF-8 string by ISO string
 *
 *  @return UTF-8 string
 */
- (NSString *)chx_convertISOString2UTF8;

/**
 *  Create ISO string by UTF-8 string
 *
 *  @return ISO string
 */
- (NSString *)chx_convertUTF8String2ISO;

@end