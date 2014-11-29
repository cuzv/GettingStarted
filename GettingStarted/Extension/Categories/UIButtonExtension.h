//
//  UIButtonExtension.h
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButtonExtension : NSObject

@end


#pragma mark - 快速生成按钮

@interface UIButton (VGenerate)

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
+ (instancetype)buttonWithFrame:(CGRect)frame
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
+ (instancetype)buttonWithSize:(CGSize)size
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
+ (instancetype)buttonWithFrame:(CGRect)frame
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
+ (instancetype)buttonWithSize:(CGSize)size
                        center:(CGPoint)center
                         title:(NSString *)title
                    titleColor:(UIColor *)titleColor
               backgroundColor:(UIColor *)backgroundColor
    highlightedBackgroundColor:(UIColor *)highlightedColor
                        target:(id)target
                        action:(SEL)selector;

@end


#pragma mark - 点击等待

@interface UIButton (VIndicatorAnimation)

/**
 *  添加等待动画
 */
- (void)addWaitingAnimation;

/**
 *  移除等待动画
 */
- (void)removeWaitingAnimation;

/**
 *  是否正在进行动画中
 *
 *  @return 是否正在进行动画中
 */
- (BOOL)isInAnimation;

@end

#pragma mark - 图片右对齐

@interface UIButton (VImageAlignment)

/**
 *  Button 图片右侧对齐
 */
- (void)updateImageAlignmentToRight;

@end

