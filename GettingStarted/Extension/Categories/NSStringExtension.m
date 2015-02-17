//
//  NSStringExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-22.
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

#import "NSStringExtension.h"

@implementation NSStringExtension
@end

#pragma mark - 计算字符串所占空间尺寸大小

@implementation NSString (CHXTextSize)

/**
 *  计算字符所占空间尺寸大小
 *
 *  @param font 字体
 *
 *  @return 空间尺寸
 */
- (CGSize)chx_sizeWithFont:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

/**
 *  计算字符所占空间尺寸大小
 *
 *  @param font  字体
 *  @param width 控件宽度
 *
 *  @return 空间尺寸
 */
- (CGSize)chx_sizeWithFont:(UIFont *)font width:(CGFloat)width {
    NSDictionary *attributes = @{NSFontAttributeName:font};
    return [self chx_sizeWithAttributes:attributes width:width];
}

- (CGSize)chx_sizeWithAttributes:(NSDictionary *)attributes width:(CGFloat)width {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin;
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
}

@end


#pragma mark - 正则验证

@implementation NSString (CHXVerification)

- (BOOL)chx_isMatchRegex:(NSString *)regex {
    NSPredicate *phoneNumerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",
                                   regex];
    return [phoneNumerTest evaluateWithObject:self];
}

// check email
- (BOOL)chx_isValidEmail {
    // @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    //    NSString *emailRegex =
    //    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    //    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    //    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    //    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    //    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    //    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    //    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    return [self chx_isMatchRegex:emailRegex];
}

// Check phone number
- (BOOL)chx_isValidPhoneNumber {
    NSString *phoneNumerRegex = @"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$";
    return [self chx_isMatchRegex:phoneNumerRegex];
}

// Check password
- (BOOL)chx_isValidPassword {
    NSString *passwordRegex = @"^\\w{6,20}$";
    return [self chx_isMatchRegex:passwordRegex];
}

// Check auth code
- (BOOL)chx_isvalidAuthCode {
    // ^\d{n}$
    NSString *authCodeRegex = @"^\\d{6}$";
    return [self chx_isMatchRegex:authCodeRegex];
}

- (BOOL)chx_isEmpty {
    return nil == self || 0 == [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length];
}

- (NSString *)chx_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end


#pragma mark -

@implementation NSString (CHXEncoding)

- (NSString *)chx_convertAsciiString2UTF8 {
    NSAssert([self isKindOfClass:[NSString class]],
             @"The input parameters is not string type!");
    
    NSStringEncoding UTF8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSStringEncoding ASCIIEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingASCII);
    NSData *ISOData = [self dataUsingEncoding:ASCIIEncoding];
    NSString *UTF8String = [[NSString alloc] initWithData:ISOData encoding:UTF8Encoding];
    return UTF8String;
}

// Create UTF8 string by ISO string
- (NSString *)chx_convertISOString2UTF8 {
    NSAssert([self isKindOfClass:[NSString class]],
             @"The input parameters is not string type!");
    
    NSStringEncoding UTF8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSStringEncoding ISOEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    NSData *ISOData = [self dataUsingEncoding:ISOEncoding];
    NSString *UTF8String = [[NSString alloc] initWithData:ISOData encoding:UTF8Encoding];
    return UTF8String;
}

// Create ISO string by UTF-8 string
- (NSString *)chx_convertUTF8String2ISO {
    NSAssert([self isKindOfClass:[NSString class]],
             @"The input parameters is not string type!");
    
    NSStringEncoding UTF8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSStringEncoding ISOEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    NSData *UTF8Data = [self dataUsingEncoding:UTF8Encoding];
    NSString *ISOString = [[NSString alloc] initWithData:UTF8Data encoding:ISOEncoding];
    return ISOString;
}

- (NSString *)chx_UTF8StringCharacterEscape {
    NSAssert([self isKindOfClass:[NSString class]],
             @"The input parameters is not string type!");
    
    NSString *description = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    description = [description stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    description = [[@"\"" stringByAppendingString:description] stringByAppendingString:@"\""];
    NSData *descriptionData = [description dataUsingEncoding:NSUTF8StringEncoding];
    
    description = [NSPropertyListSerialization propertyListWithData:descriptionData options:NSPropertyListImmutable format:NULL error:nil];
    
    return description;
}

@end
