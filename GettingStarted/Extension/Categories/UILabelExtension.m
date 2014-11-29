//
//  UILabelExtension.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UILabelExtension.h"

@implementation UILabelExtension

@end


#pragma mark - 快速生成标签

@implementation UILabel (VGenerate)

+ (instancetype)labelWithFrame:(CGRect)frame
                 textAlignment:(NSTextAlignment)alignment
                          font:(UIFont *)font
                     textColor:(UIColor *)color {
    UILabel *label = [[self alloc] initWithFrame:frame];
    label.textAlignment = alignment ? : NSTextAlignmentLeft;
    label.font = font ? : [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    label.textColor = color ? : [UIColor whiteColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    return label;
}

+ (instancetype)labelWithSize:(CGSize)size
                       center:(CGPoint)center
                textAlignment:(NSTextAlignment)alignment
                         font:(UIFont *)font
                    textColor:(UIColor *)textColor {
    CGRect frame = CGRectMake(center.x - size.width / 2,
                              center.y - size.height / 2,
                              size.width,
                              size.height);
    return [self labelWithFrame:frame textAlignment:alignment font:font textColor:textColor];
}

@end