//
//  NSStringCategories.h
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSStringCategories : NSObject
@end

#pragma mark - 计算字符串所占空间尺寸大小

@interface NSString (TextSize)

/**
 *  根据字体获取所占空间尺寸大小
 *
 *  @param font 字体
 *
 *  @return 尺寸大小
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  根据字体获取所占空间尺寸大小
 *
 *  @param font  字体
 *  @param width 最大宽度
 *
 *  @return 尺寸大小
 */
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width;

@end
