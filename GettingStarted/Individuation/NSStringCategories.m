//
//  NSStringCategories.m
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "NSStringCategories.h"

@implementation NSStringCategories
@end

#pragma mark - 计算字符串所占空间尺寸大小

@implementation NSString (TextSize)

- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width {
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
                                     NSStringDrawingUsesFontLeading |
                                     NSStringDrawingUsesLineFragmentOrigin;
    return[self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                             options:options
                          attributes:@{NSFontAttributeName:font}
                             context:nil].size;
}

@end

