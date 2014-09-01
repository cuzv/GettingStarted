//
//  UIAlertView+Generate.m
//  GettingStarted
//
//  Created by Moch on 9/1/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIAlertView+Generate.h"

@implementation UIAlertView (Generate)

+ (void)alertWithMessage:(NSString *)message {
    UIAlertView *alert = [[self alloc] initWithTitle:nil
                                             message:message
                                            delegate:nil
                                   cancelButtonTitle:nil
                                   otherButtonTitles:@"确定", nil];
    [alert show];
}

+ (void)alertWithAutomaticDisappearMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:message
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil];
    
    [alertView show];
    
    NSMethodSignature *signature = [UIAlertView instanceMethodSignatureForSelector:
                                    @selector(dismissWithClickedButtonIndex:animated:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:alertView];
    [invocation setSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    NSInteger index = 0;
    [invocation setArgument:&index atIndex:2];
    BOOL animated = YES;
    [invocation setArgument:&animated atIndex:3];
    [invocation retainArguments];
    [invocation performSelector:@selector(invoke) withObject:nil afterDelay:1];
}

@end
