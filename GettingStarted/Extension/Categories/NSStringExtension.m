//
//  NSStringExtension.m
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "NSStringExtension.h"

@implementation NSStringExtension
@end

#pragma mark - 计算字符串所占空间尺寸大小

@implementation NSString (TextSize)

/**
 *  计算字符所占空间尺寸大小
 *
 *  @param font 字体
 *
 *  @return 空间尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font {
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
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
                                     NSStringDrawingUsesFontLeading |
                                     NSStringDrawingUsesLineFragmentOrigin;
    return[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                             options:options
                          attributes:@{NSFontAttributeName:font}
                             context:nil].size;
}

@end


#pragma mark - 正则验证

@implementation NSString (Verification)

- (BOOL)isMatchRegex:(NSString *)regex {
	NSPredicate *phoneNumerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",
								   regex];
	return [phoneNumerTest evaluateWithObject:self];
}

// check email
- (BOOL)isValidEmail {
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

	return [self isMatchRegex:emailRegex];
}

// Check phone number
- (BOOL)isValidPhoneNumber {
    NSString *phoneNumerRegex = @"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$";
	return [self isMatchRegex:phoneNumerRegex];
}

// Check password
- (BOOL)isValidPassword {
    NSString *passwordRegex = @"^\\w{6,20}$";
    return [self isMatchRegex:passwordRegex];
}

// Check auth code
- (BOOL)isvalidAuthCode {
    // ^\d{n}$
    NSString *authCodeRegex = @"^\\d{6}$";
    return [self isMatchRegex:authCodeRegex];
}

- (BOOL)isEmpty {
    return nil == self || 0 == [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end


#pragma mark - 

@implementation NSString (Encoding)

// Create UTF8 string by ISO string
- (NSString *)convertISOString2UTF8 {
	NSAssert([self isKindOfClass:[NSString class]],
			 @"The input parameters is not string type!");
	
	NSStringEncoding UTF8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
	NSStringEncoding ISOEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
	NSData *ISOData = [self dataUsingEncoding:ISOEncoding];
	NSString *UTF8String = [[NSString alloc] initWithData:ISOData encoding:UTF8Encoding];
	return UTF8String;
}

// Create ISO string by UTF-8 string
- (NSString *)convertUTF8String2ISO {
	NSAssert([self isKindOfClass:[NSString class]],
			 @"The input parameters is not string type!");
	
	NSStringEncoding UTF8Encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
	NSStringEncoding ISOEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
	NSData *UTF8Data = [self dataUsingEncoding:UTF8Encoding];
	NSString *ISOString = [[NSString alloc] initWithData:UTF8Data encoding:ISOEncoding];
	return ISOString;
}

@end
