//
//  UIAlertViewExtension.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIAlertViewExtension.h"

@implementation UIAlertViewExtension

@end

#pragma mark - 快速生成提示框

@implementation UIAlertView (Generate)

+ (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alertView = [[self alloc] initWithTitle:@""
                                                 message:message
                                                delegate:nil
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"好", nil];
    [alertView show];
}

#define kAlertDelayTimeInterval 5
+ (void)showAlertWithAutomaticDisappearMessage:(NSString *)message {
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

+ (void)showAlertWithAutomaticDisappearMessage:(NSString *)message delayTimeInterval:(NSTimeInterval)delay {
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

