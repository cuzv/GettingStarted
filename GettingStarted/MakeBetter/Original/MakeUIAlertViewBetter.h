//
//  MakeUIAlertViewBetter.h
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MakeUIAlertViewBetter : NSObject
@end

#pragma mark - 快速生成提示框

@interface UIAlertView (Generate)

/**
 *  弹出提示框
 *
 *  @param message 提示信息
 */
+ (void)alertWithMessage:(NSString *)message;

/**
 *  弹出会自动消失的提示框，默认5秒后消失
 *
 *  @param message 提示信息
 */
+ (void)alertWithAutomaticDisappearMessage:(NSString *)message;

/**
 *  弹出会自动消失的提示框，指定消失延迟时长
 *
 *  @param message 提示信息
 *  @param delay   延时时长
 */
+ (void)alertWithAutomaticDisappearMessage:(NSString *)message delayTimeInterval:(NSTimeInterval)delay;

@end

