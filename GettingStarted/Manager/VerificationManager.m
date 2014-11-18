//
//  VerificationManager.m
//  WFarm
//
//  Created by Moch on 8/20/14.
//  Copyright (c) 2014 BSG. All rights reserved.
//

#import "VerificationManager.h"
#import "UIAlertViewExtension.h"

NSString *const CHPhoneNumberCanNotBeNull = @"手机号不能为空";
NSString *const CHPhoneNumberInvalid = @"手机号格式错误";

NSString *const CHPasswordCanNotBeNull = @"密码不能为空";
NSString *const CHPasswordInvalid = @"密码格式错误";
NSString *const CHPasswordRepeatInvalid = @"两次输入密码不一致";

NSString *const CHAuthCodeCanNotBeNull = @"验证码不能为空";
NSString *const CHAuthCodeInvalid = @"验证码格式错误";

@implementation VerificationManager

#pragma mark - public messages

+ (BOOL)verifyingPhone:(NSString *)phoneNumber {
    if (!phoneNumber.length) {
        [UIAlertView showAlertWithMessage:CHPhoneNumberCanNotBeNull];
        return NO;
    }
    if (![self isValidPhoneNumber:phoneNumber]) {
        [UIAlertView showAlertWithMessage:CHPhoneNumberInvalid];
        return NO;
    }
    return YES;
}

+ (BOOL)verifyingPassword:(NSString *)password {
    if (!password.length) {
        [UIAlertView showAlertWithMessage:CHPasswordCanNotBeNull];
        return NO;
    }
    if (![self isValidPassword:password]) {
        [UIAlertView showAlertWithMessage:CHPasswordInvalid];
        return NO;
    }
    return YES;
}

+ (BOOL)verifyingPassword:(NSString *)password repeat:(NSString *)repeat {
    if (![self verifyingPassword:password]) {
        return NO;
    }
    if (![password isEqualToString:repeat]) {
        [UIAlertView showAlertWithMessage:CHPasswordRepeatInvalid];
        return NO;
    }
    return YES;
}

+ (BOOL)verifyingAuthCode:(NSString *)authCode {
    if (!authCode.length) {
        [UIAlertView showAlertWithMessage:CHAuthCodeCanNotBeNull];
        return NO;
    }
    if (![self isvalidAuthCode:authCode]) {
        [UIAlertView showAlertWithMessage:CHAuthCodeInvalid];
        return NO;
    }
    return YES;
}

#pragma mark - privte messages

// check email
+ (BOOL)isValidEmail:(NSString *)email {
    // @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",
                              emailRegex];
    return [emailTest evaluateWithObject:email];
}

// check phone number
+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber {

    NSString *phoneNumerRegex = @"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$";
    NSPredicate *phoneNumerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",
                                   phoneNumerRegex];
    return [phoneNumerTest evaluateWithObject:phoneNumber];
}

// check password
+ (BOOL)isValidPassword:(NSString *)password {
    NSString *passwordRegex = @"^\\w{6,20}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",
                                 passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

// check auth code
+ (BOOL)isvalidAuthCode:(NSString *)authCode {
    // ^\d{n}$
    NSString *authCodeRegex = @"^\\d{6}$";
    NSPredicate *authCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",
                                 authCodeRegex];
    return [authCodeTest evaluateWithObject:authCode];
}


@end
