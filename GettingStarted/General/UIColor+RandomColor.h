//
//  UIColor+RandomColor.h
//  GettingStarted
//
//  Created by Moch on 8/25/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RandomColor)

+ (UIColor *)randomRGBColor;
+ (UIColor *)randomSHBColor;

+ (UIColor *)colorWithRGBA:(NSArray *)rgba;

@end
