//
//  UILabelExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/29/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
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