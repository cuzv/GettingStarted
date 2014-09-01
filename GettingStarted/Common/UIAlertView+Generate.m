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

@end
