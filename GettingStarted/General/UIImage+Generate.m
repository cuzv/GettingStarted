//
//  UIImage+Generate.m
//  GettingStarted
//
//  Created by 肖川 on 14-5-20.
//  Copyright (c) 2014年 anzeinfo. All rights reserved.
//

#import "UIImage+Generate.h"

@implementation UIImage (Generate)

+ (UIImage *)imageWithColor:(UIColor *)aColor {
    return [self imageWithColor:aColor size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)aColor size:(CGSize)aSize {
    UIGraphicsBeginImageContext(aSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGRect rect = CGRectMake(0, 0, aSize.width, aSize.height);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        
    return image;
}


@end
