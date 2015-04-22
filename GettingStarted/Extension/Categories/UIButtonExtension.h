//
//  UIButtonExtension.h
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

@interface UIButtonExtension : NSObject

@end


#pragma mark - 快速生成按钮

@interface UIButton (CHXGenerate)

/**
 *  快速生成按钮，适用于只提供图片的方式
 *
 *  @param frame            位置
 *  @param backgroundImage  背景图片
 *  @param highlightedImage 高亮状态背景图片
 *  @param target           目标对象
 *  @param selector         响应事件
 *
 *  @return 按钮
 */
+ (instancetype)chx_buttonWithFrame:(CGRect)frame
					backgroundImage:(UIImage *)backgroundImage
				   highlightedImage:(UIImage *)highlightedImage
							 target:(id)target
							 action:(SEL)selector;

/**
 *  快速生成按钮，适用于只提供图片的方式
 *
 *  @param size             尺寸大小
 *  @param center           中心点
 *  @param backgroundImage  背景图片
 *  @param highlightedImage 高亮状态背景图片
 *  @param target           目标对象
 *  @param selector         响应事件
 *
 *  @return 按钮
 */
+ (instancetype)chx_buttonWithSize:(CGSize)size
							center:(CGPoint)center
				   backgroundImage:(UIImage *)backgroundImage
				  highlightedImage:(UIImage *)highlightedImage
							target:(id)target
							action:(SEL)selector;

/**
 *  快速生成按钮，适用于提供文字和颜色的方式
 *
 *  @param frame            位置
 *  @param title            文字
 *  @param titleColor       文字颜色
 *  @param backgroundColor  背景颜色
 *  @param highlightedColor 高亮背景颜色
 *  @param target           目标对象
 *  @param selector         响应事件
 *
 *  @return 按钮
 */
+ (instancetype)chx_buttonWithFrame:(CGRect)frame
							  title:(NSString *)title
						 titleColor:(UIColor *)titleColor
					backgroundColor:(UIColor *)backgroundColor
		 highlightedBackgroundColor:(UIColor *)highlightedColor
							 target:(id)target
							 action:(SEL)selector;

/**
 *  快速生成按钮，适用于提供文字和颜色的方式
 *
 *  @param size             尺寸大小
 *  @param center           中心点
 *  @param title            文字
 *  @param titleColor       文字颜色
 *  @param backgroundColor  背景颜色
 *  @param highlightedColor 高亮背景颜色
 *  @param target           目标对象
 *  @param selector         响应事件
 *
 *  @return 按钮
 */
+ (instancetype)chx_buttonWithSize:(CGSize)size
							center:(CGPoint)center
							 title:(NSString *)title
						titleColor:(UIColor *)titleColor
				   backgroundColor:(UIColor *)backgroundColor
		highlightedBackgroundColor:(UIColor *)highlightedColor
							target:(id)target
							action:(SEL)selector;

@end


#pragma mark - 点击等待

@interface UIButton (CHXIndicatorAnimation)

/**
 *  添加等待动画
 */
- (void)chx_addWaitingAnimation;

/**
 *  移除等待动画
 */
- (void)chx_removeWaitingAnimation;

/**
 *  是否正在进行动画中
 *
 *  @return 是否正在进行动画中
 */
- (BOOL)chx_isInAnimation;

@end

#pragma mark - 图片右对齐

@interface UIButton (VImageAlignment)

/**
 *  Button 图片右侧对齐
 */
- (void)chx_updateImageAlignmentToRight;

/**
 *  Button 图片上侧对齐
 */
- (void)chx_updateImageAlignmentToUp;

@end

#pragma mark - 扩大点击范围

@interface UIButton (CHXExpandRegion)
/**
 *  扩大点击区域
 *
 *  @param inset 区域
 */
- (void)chx_setExpandRegion:(UIEdgeInsets)inset;
@end

