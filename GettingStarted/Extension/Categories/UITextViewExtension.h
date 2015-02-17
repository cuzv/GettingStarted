//
//  UITextViewExtension.h
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

@interface UITextViewExtension : NSObject

@end


#pragma mark - 快速创建文本框

@interface UITextView (CHXGenerate)

/**
 *  快速创建文本框
 *
 *  @param frame    位置
 *  @param font     字体
 *  @param delegate 委托
 *  @param display  是否显示边框
 *
 *  @return 文本域
 */
+ (instancetype)chx_textViewWithFrame:(CGRect)frame
                                 font:(UIFont *)font
                             delegate:(id<UITextViewDelegate>)delegate
                   displayBorderLayer:(BOOL)display;

/**
 *  快速创建文本框
 *
 *  @param size     大小
 *  @param center   中心点
 *  @param font     字体
 *  @param delegate 委托
 *  @param display  是否显示边框
 *
 *  @return 文本域
 */
+ (instancetype)chx_textViewWithSize:(CGSize)size
                              center:(CGPoint)center
                                font:(UIFont *)font
                            delegate:(id<UITextViewDelegate>)delegate
                  displayBorderLayer:(BOOL)display;
@end
