//
//  UIView+BorderLine.h
//  GettingStarted
//
//  Created by Moch on 14-5-16.
//  Copyright (c) 2014年 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kColorDigit (213 / 255)
#define BorderLineGrayColor [UIColor colorWithRed:kColorDigit green:kColorDigit blue:kColorDigit alpha:kColorDigit]

typedef NS_ENUM(NSInteger, CHEdgeOrientation) {
    CHEdgeOrientationTop,
    CHEdgeOrientationLeft,
    CHEdgeOrientationBottom,
    CHEdgeOrientationRight
};

@interface UIView (BorderLine)

- (void)setBorderLineColor:(UIColor *)aColor;
- (void)setBorderLineColor:(UIColor *)aColor edgeOrientation:(CHEdgeOrientation)orientation;

@end
