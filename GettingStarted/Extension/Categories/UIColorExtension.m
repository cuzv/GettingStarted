//
//  UIColorExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 10/24/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "UIColorExtension.h"

@implementation UIColorExtension
@end

#pragma mark - 生成颜色

@implementation UIColor (CHXRandomColor)

+ (UIColor *)chx_randomRGBColor {
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        // srandom()这个函数是初始化随机数产生器
        srandom((unsigned)time(NULL));
    }
    // random()函数产生随即值
    CGFloat red   = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue  = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)chx_randomSHBColor {
    //  0.0 to 1.0
    CGFloat hue = arc4random() % 256 / 256.0 ;
    //  0.5 to 1.0, away from white
    CGFloat saturation = arc4random() % 128 / 256.0 + 0.5;
    //  0.5 to 1.0, away from black
    CGFloat brightness = arc4random() % 128 / 256.0 + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *)chx_colorWithRGBA:(NSArray *)rgba {
	NSAssert(rgba.count == 4, @"Color array should have four parameters !");
    return [UIColor colorWithRed:[rgba[0] floatValue] / 255
                           green:[rgba[1] floatValue] / 255
                            blue:[rgba[2] floatValue] / 255
                           alpha:[rgba[3] floatValue] / 1];
}

@end
