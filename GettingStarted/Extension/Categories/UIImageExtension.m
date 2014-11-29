//
//  UIImageExtension.m
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIImageExtension.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImageExtension
@end

#pragma mark - 获取 NSBundle 中的图片

@implementation UIImage (VFetch)

+ (UIImage *)imageWithName:(NSString *)imageName {
    return [self imageWithName:imageName suffix:@"png"];
}

+ (UIImage *)imageWithName:(NSString *)imageName suffix:(NSString *)aSuffix {
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:aSuffix]];
}

+ (UIImage *)imageWithNameHasSuffix:(NSString *)aNameHasSuffix {
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:aNameHasSuffix]];
}

@end


#pragma mark - 快速生成图片

@implementation UIImage (VGenerate)

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

+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end

