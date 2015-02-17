//
//  NSStringExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 2015-01-09.
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

/**
 *  根据字体属性获取所占空间尺寸大小
 *
 *  @param attributes 属性
 *  @param width      最大宽度
 *
 *  @return 尺寸大小
 */
- (CGSize)chx_sizeWithAttributes:(NSDictionary *)attributes width:(CGFloat)width;

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
 *  Create UTF-8 string by ASCII string
 *
 *  @return ASCII string
 */
- (NSString *)chx_convertAsciiString2UTF8;

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

/**
 *  转义 UTF-8 字符串字符，让其适合在终端输出中文
 *
 *  @return UTF-8 转义字符串
 */
- (NSString *)chx_UTF8StringCharacterEscape;

@end