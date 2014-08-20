//
//  UIImage+Fetch.h
//  面试职通车
//
//  Created by 萧川 on 14-4-18.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Fetch)

// 通过名字获取图片，不带后缀，png图片
+ (UIImage *)imageWithName:(NSString *)aName;

// 通过名字和后缀获取图片
+ (UIImage *)imageWithName:(NSString *)aName suffix:(NSString *)aSuffix;

// 通过带后缀名字获取图片
+ (UIImage *)imageWithNameHasSuffix:(NSString *)aNameHasSuffix;

@end
