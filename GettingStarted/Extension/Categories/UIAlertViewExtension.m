//
//  UIAlertViewExtension.m
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

#import "UIAlertViewExtension.h"

@implementation UIAlertViewExtension

@end

#pragma mark - 快速生成提示框

@implementation UIAlertView (CHXGenerate)

+ (void)chx_showAlertWithMessage:(NSString *)message {
    UIAlertView *alertView = [[self alloc] initWithTitle:@""
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"好", nil];
    [alertView show];
}

#define kAlertDelayTimeInterval 5
+ (void)chx_showAlertWithAutomaticDisappearMessage:(NSString *)message {
    UIAlertView *alertView = [[self alloc] initWithTitle:@""
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"好", nil];
    [alertView show];
    
    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:
                                    @selector(dismissWithClickedButtonIndex:animated:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:alertView];
    [invocation setSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    NSInteger index = 0;
    [invocation setArgument:&index atIndex:2];
    BOOL animated = YES;
    [invocation setArgument:&animated atIndex:3];
    [invocation retainArguments];
    [invocation performSelector:@selector(invoke) withObject:nil afterDelay:kAlertDelayTimeInterval];
}

+ (void)chx_showAlertWithAutomaticDisappearMessage:(NSString *)message delayTimeInterval:(NSTimeInterval)delay {
    UIAlertView *alertView = [[self alloc] initWithTitle:@""
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"好", nil];
    [alertView show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });
}

@end

