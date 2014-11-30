//
//  UIColorExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/24/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColorExtension : NSObject
@end

#pragma mark - 生成颜色

@interface UIColor (CHXRandomColor)

/**
 *  随机生成 RGB 颜色
 *
 *  @return RGB 颜色
 */
+ (UIColor *)chx_randomRGBColor;

/**
 *  随机生成 SHB 颜色
 *
 *  @return SHB 颜色
 */
+ (UIColor *)chx_randomSHBColor;

/**
 *  根据 RGB 值生成颜色
 *
 *  @param rgba RGB 颜色，例如 @[@112, @112, @112, @0.5]
 *
 *  @return RGB 颜色
 */
+ (UIColor *)chx_colorWithRGBA:(NSArray *)rgba;

@end

