//
//  UIAlertViewExtension.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertViewExtension : NSObject

@end


#pragma mark - 快速生成提示框

@interface UIAlertView (CHXGenerate)

/**
 *  弹出提示框
 *
 *  @param message 提示信息
 */
+ (void)chx_showAlertWithMessage:(NSString *)message;

/**
 *  弹出会自动消失的提示框，默认5秒后消失
 *
 *  @param message 提示信息
 */
+ (void)chx_showAlertWithAutomaticDisappearMessage:(NSString *)message;

/**
 *  弹出会自动消失的提示框，指定消失延迟时长
 *
 *  @param message 提示信息
 *  @param delay   延时时长
 */
+ (void)chx_showAlertWithAutomaticDisappearMessage:(NSString *)message delayTimeInterval:(NSTimeInterval)delay;

@end

