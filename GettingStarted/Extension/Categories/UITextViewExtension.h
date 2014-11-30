//
//  UITextViewExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/29/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
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
