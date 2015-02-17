//
//  CHXVerificationManager.m
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
    if (![self __isValidPhoneNumber:phoneNumber]) {
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
    if (![self __isValidPassword:password]) {
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
    if (![self __isvalidAuthCode:authCode]) {
        [UIAlertView chx_showAlertWithMessage:CHAuthCodeInvalid];
        return NO;
    }
    return YES;
}

#pragma mark - privte messages

// check email
+ (BOOL)__isValidEmail:(NSString *)email {
    // @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    //    NSString *emailRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    return [email chx_isValidEmail];
}

// check phone number
+ (BOOL)__isValidPhoneNumber:(NSString *)phoneNumber {
    return [phoneNumber chx_isValidPhoneNumber];
}

// check password
+ (BOOL)__isValidPassword:(NSString *)password {
    return [password chx_isValidPassword ];
}

// check auth code
+ (BOOL)__isvalidAuthCode:(NSString *)authCode {
    // ^\d{n}$
    return [authCode chx_isvalidAuthCode];
}

@end
