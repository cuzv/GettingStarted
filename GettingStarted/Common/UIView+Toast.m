//
//  UIView+Toast.m
//  GettingStarted
//
//  Created by Moch on 8/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIView+Toast.h"
#import "PaddingLabel.h"
#import "NSString+TextSize.h"
#import "UIView+BorderLine.m"
#import "UIView+Animation.h"

#define kDelayDuration 1.5
#define kAnimationDuration 0.0
#define kHorizontalDistanceForEdges 60

@implementation UIView (Toast)

+ (void)toastWithMessage:(NSString *)message
       appearOrientation:(CHToastAppearOrientation)orientation {
    if (!message.length) {
        return;
    }

    // prepare toast display label
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    CGSize size = [message sizeWithFont:font width:CGRectGetWidth([[UIScreen mainScreen] bounds]) - kHorizontalDistanceForEdges * 2];
    PaddingLabel *toastLabel = [PaddingLabel new];
    CGFloat paddingEdgeInsetsSideLength = toastLabel.edgeInsets.left + toastLabel.edgeInsets.right;
    toastLabel.bounds = CGRectMake(0, 0, size.width + paddingEdgeInsetsSideLength, size.height + paddingEdgeInsetsSideLength);
    toastLabel.backgroundColor = [UIColor blackColor];
    toastLabel.textColor = [UIColor whiteColor];
    toastLabel.textAlignment = NSTextAlignmentLeft;
    toastLabel.contentMode = UIViewContentModeCenter;
    toastLabel.numberOfLines = 0;
    toastLabel.layer.cornerRadius = 5;
    toastLabel.layer.masksToBounds = YES;
    toastLabel.font = font;
    toastLabel.text = message;
    // resolve label right edge hava a gray line problem
    [toastLabel setBorderLineColor:toastLabel.backgroundColor];
    // toast can display on top of keyboard
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:toastLabel];
    
    // prepare animations
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (orientation == CHToastAppearOrientationTop) {
        toastLabel.center = CGPointMake(bounds.size.width / 2 , CGRectGetMidY(toastLabel.bounds) + kTopVerticalDistanceForEdges);
    } else if (orientation == CHToastAppearOrientationBottom) {
        toastLabel.center = CGPointMake(bounds.size.width / 2 , bounds.size.height - toastLabel.bounds.size.height - kBottomVerticalDistanceForEdges);
    }
    
    // run animation
    [toastLabel shakeForToastAppearOrientation:orientation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            toastLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [toastLabel removeFromSuperview];
        }];
    });
}

+ (void)toastWithMessage:(NSString *)message {
    [self toastWithMessage:message appearOrientation:CHToastAppearOrientationTop];
}

@end