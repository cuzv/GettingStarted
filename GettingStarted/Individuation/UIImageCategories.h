//
//  UIImageCategories.h
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageCategories : NSObject
@end

#pragma mark - 获取 NSBundle 中的图片

@interface UIImage (Fetch)

/**
 *  通过名字获取图片，不带后缀，png 格式图片
 *
 *  @param imageName 图片名字
 *
 *  @return 图片
 */
+ (UIImage *)imageWithName:(NSString *)imageName;

/**
 *  通过名字和后缀获取图片
 *
 *  @param imageName   图片名字
 *  @param aSuffix 后缀命，不带 '.'
 *
 *  @return 图片
 */
+ (UIImage *)imageWithName:(NSString *)imageName suffix:(NSString *)aSuffix;

/**
 *  通过带后缀名字获取图片
 *
 *  @param aNameHasSuffix 图片全名，带后缀
 *
 *  @return 图片
 */
+ (UIImage *)imageWithNameHasSuffix:(NSString *)aNameHasSuffix;

@end


#pragma mark - 快速生成图片

@interface UIImage (Generate)

/**
 *  根据颜色快速生成图片
 *
 *  @param aColor 图片颜色
 *
 *  @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)aColor;

/**
 *  根据颜色生成指定大小的图片
 *
 *  @param aColor 图片颜色
 *  @param aSize  图片尺寸大小
 *
 *  @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)aColor size:(CGSize)aSize;

@end
