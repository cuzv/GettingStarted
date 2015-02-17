//
//  UILabelExtension.h
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

@interface UILabelExtension : NSObject

@end


#pragma mark - 快速生成标签

@interface UILabel (CHXGenerate)

/**
 *  快速创建标签
 *
 *  @param frame     位置
 *  @param alignment 对齐方式
 *  @param font      字体
 *  @param color     文本颜色
 *
 *  @return 标签
 */
+ (instancetype)chx_labelWithFrame:(CGRect)frame
                     textAlignment:(NSTextAlignment)alignment
                              font:(UIFont *)font
                         textColor:(UIColor *)color;

/**
 *  快速创建标签
 *
 *  @param size      大小
 *  @param center    中心点
 *  @param alignment 对齐方式
 *  @param font      字体
 *  @param color     文本颜色
 *
 *  @return 标签
 */
+ (instancetype)chx_labelWithSize:(CGSize)size
                           center:(CGPoint)center
                    textAlignment:(NSTextAlignment)alignment
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor;

@end