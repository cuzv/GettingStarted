//
//  UITextFieldExtension.h
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextFieldExtension : NSObject

@end


#pragma mark - 快速创建文本域

@interface UITextField (Generate)

/**
 *  快速创建文本域
 *
 *  @param frame     位置
 *  @param alignment 对齐方式
 *  @param font      子图
 *  @param display   是否显示边框
 *
 *  @return 文本域
 */
+ (instancetype)textFieldWithFrame:(CGRect)frame
                     textAlignment:(NSTextAlignment)alignment
                              font:(UIFont *)font
                displayBorderLayer:(BOOL)display;

/**
 *  快速创建文本域
 *
 *  @param size      大小
 *  @param center    中心点
 *  @param alignment 对齐方式
 *  @param font      子图
*  @param display    是否显示边框
 *
 *  @return 文本域
 */
+ (instancetype)textFieldWithSize:(CGSize)size
                           center:(CGPoint)center
                    textAlignment:(NSTextAlignment)alignment
                             font:(UIFont *)font
               displayBorderLayer:(BOOL)display;
@end
