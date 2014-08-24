//
//  UIColor+RandomColor.m
//  GettingStarted
//
//  Created by Moch on 8/25/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (UIColor *)randomRGBColor {
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        // srandom()这个函数是初始化随机数产生器
        srandom(time(NULL));
    }
    // random()函数产生随即值
    CGFloat red   = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue  = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)randomSHBColor {
    //  0.0 to 1.0
    CGFloat hue = arc4random() % 256 / 256.0 ;
    //  0.5 to 1.0, away from white
    CGFloat saturation = arc4random() % 128 / 256.0 + 0.5;
    //  0.5 to 1.0, away from black
    CGFloat brightness = arc4random() % 128 / 256.0 + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *)colorWithRGBA:(NSArray *)rgba {
    return [UIColor colorWithRed:[rgba[0] floatValue] / 255 green:[rgba[1] floatValue] / 255 blue:[rgba[2] floatValue] / 255 alpha:[rgba[3] floatValue] / 1];
}

@end
