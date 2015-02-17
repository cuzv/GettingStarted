//
//  UIImageExtension.h
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

@interface UIImageExtension : NSObject
@end

#pragma mark - 获取 NSBundle 中的图片

@interface UIImage (CHXFetch)

/**
 *  通过名字获取图片，不带后缀，png 格式图片
 *
 *  @param imageName 图片名字
 *
 *  @return 图片
 */
+ (UIImage *)chx_imageWithName:(NSString *)imageName;

/**
 *  通过名字和后缀获取图片
 *
 *  @param imageName   图片名字
 *  @param aSuffix 后缀命，不带 '.'
 *
 *  @return 图片
 */
+ (UIImage *)chx_imageWithName:(NSString *)imageName suffix:(NSString *)aSuffix;

/**
 *  通过带后缀名字获取图片
 *
 *  @param aNameHasSuffix 图片全名，带后缀
 *
 *  @return 图片
 */
+ (UIImage *)chx_imageWithNameHasSuffix:(NSString *)aNameHasSuffix;

@end


#pragma mark - 快速生成图片

@interface UIImage (CHXGenerate)

/**
 *  根据颜色快速生成图片
 *
 *  @param aColor 图片颜色
 *
 *  @return 生成的图片
 */
+ (UIImage *)chx_imageWithColor:(UIColor *)aColor;

/**
 *  根据颜色生成指定大小的图片
 *
 *  @param aColor 图片颜色
 *  @param aSize  图片尺寸大小
 *
 *  @return 生成的图片
 */
+ (UIImage *)chx_imageWithColor:(UIColor *)aColor size:(CGSize)aSize;

/**
 *  截屏，iOS 7 以前
 *
 *  @param view 需要被截屏的视图
 *
 *  @return 图片
 */
+ (UIImage *)chx_captureImageFromView:(UIView *)view;

@end
