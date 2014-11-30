//
//  VerificationManager.m
//  WFarm
//
//  Created by Moch Xiao on 8/20/14.
//  Copyright (c) 2014 BSG. All rights reserved.
//

#import "CHXVerificationManager.h"
#import "UIAlertViewExtension.h"
#import "NSStringExtension.h"

NSString *const CHPhoneNumberCanNotBeNull = @"手机号不能为空";
NSString *const CHPhoneNumberInvalid = @"手机号格式错误";

NSString *const CHPasswordCanNotBeNull = @"密码不能为空";
NSString *const CHPasswordInvalid = @"密码格式错误";
NSString *const CHPasswordRepeatInvalid = @"两次输入密码不一致";

NSString *const CHAuthCodeCanNotBeNull = @"验证码不能为空";
NSString *const CHAuthCodeInvalid = @"验证码格式错误";

@implementation CHXVerificationManager

#pragma mark - public messages

+ (BOOL)verifyingPhone:(NSString *)phoneNumber {
    if (!phoneNumber.length) {
        [UIAlertView chx_showAlertWithMessage:CHPhoneNumberCanNotBeNull];
        return NO;
    }
    if (![self isValidPhoneNumber:phoneNumber]) {
        [UIAlertView chx_showAlertWithMessage:CHPhoneNumberInvalid];
        return NO;
    }
    return YES;
}

+ (BOOL)verifyingPassword:(NSString *)password {
    if (!password.length) {
        [UIAlertView chx_showAlertWithMessage:CHPasswordCanNotBeNull];
        return NO;
    }
    if (![self isValidPassword:password]) {
        [UIAlertView chx_showAlertWithMessage:CHPasswordInvalid];
        return NO;
    }
    return YES;
}

+ (BOOL)verifyingPassword:(NSString *)password repeat:(NSString *)repeat {
    if (![self verifyingPassword:password]) {
        return NO;
    }
    if (![password isEqualToString:repeat]) {
        [UIAlertView chx_showAlertWithMessage:CHPasswordRepeatInvalid];
        return NO;
    }
    return YES;
}

+ (BOOL)verifyingAuthCode:(NSString *)authCode {
    if (!authCode.length) {
        [UIAlertView chx_showAlertWithMessage:CHAuthCodeCanNotBeNull];
        return NO;
    }
    if (![self isvalidAuthCode:authCode]) {
        [UIAlertView chx_showAlertWithMessage:CHAuthCodeInvalid];
        return NO;
    }
    return YES;
}

#pragma mark - privte messages

// check email
+ (BOOL)isValidEmail:(NSString *)email {
    // @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
	return [email chx_isValidEmail];
}

// check phone number
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber {
	return [phoneNumber chx_isValidPhoneNumber];
}

// check password
+ (BOOL)isValidPassword:(NSString *)password {
    return [password chx_isValidPassword ];
}

// check auth code
+ (BOOL)isvalidAuthCode:(NSString *)authCode {
    // ^\d{n}$
	return [authCode chx_isvalidAuthCode];
}

@end
