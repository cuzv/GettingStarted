//
//  UIButtonCategories.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIButtonCategories.h"
#import "UIImageCategories.h"
#import "UIViewCategories.h"

@implementation UIButtonCategories

@end


#pragma mark - 快速生成按钮

@implementation UIButton (Generate)

+ (instancetype)buttonWithFrame:(CGRect)frame
                backgroundImage:(UIImage *)backgroundImage
               highlightedImage:(UIImage *)highlightedImage
                         target:(id)target
                         action:(SEL)selector {
    UIButton *button = [[self alloc] initWithFrame:frame];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    
    return button;
}

+ (instancetype)buttonWithSize:(CGSize)size
                          center:(CGPoint)center
                backgroundImage:(UIImage *)backgroundImage
               highlightedImage:(UIImage *)highlightedImage
                         target:(id)target
                         action:(SEL)selector {
    CGRect frame = CGRectMake(center.x - size.width / 2,
                              center.y - size.height / 2,
                              size.width,
                              size.height);
    return [self buttonWithFrame:frame
                 backgroundImage:backgroundImage
                highlightedImage:highlightedImage
                          target:target
                          action:selector];;
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                backgroundColor:(UIColor *)backgroundColor
     highlightedBackgroundColor:(UIColor *)highlightedColor
                         target:(id)target
                         action:(SEL)selector {
    UIButton *button = [[self alloc] initWithFrame:frame];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    
    if (backgroundColor) {
        UIImage *backgroundImage = [UIImage imageWithColor:backgroundColor size:frame.size];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    if (highlightedColor) {
        UIImage *highlightedImage = [UIImage imageWithColor:highlightedColor size:frame.size];
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    [button setCornerRadius:5];
    
    return button;
}

+ (instancetype)buttonWithSize:(CGSize)size
                        center:(CGPoint)center
                         title:(NSString *)title
                    titleColor:(UIColor *)titleColor
               backgroundColor:(UIColor *)backgroundColor
    highlightedBackgroundColor:(UIColor *)highlightedColor
                        target:(id)target
                        action:(SEL)selector {
    CGRect frame = CGRectMake(center.x - size.width / 2,
                              center.y - size.height / 2,
                              size.width,
                              size.height);
    return [self buttonWithFrame:frame
                           title:title
                      titleColor:titleColor
                 backgroundColor:backgroundColor
      highlightedBackgroundColor:highlightedColor
                          target:target
                          action:selector];
}


@end