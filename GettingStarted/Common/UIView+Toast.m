//
//  UIView+Toast.m
//  GettingStarted
//
//  Created by Moch on 8/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIView+Toast.h"
#import "PaddingLabel.h"
#define kDelayDuration 1.5
#define kAnimationDuration 0.3

@implementation UIView (Toast)

+ (void)toastWithMessage:(NSString *)message appearOrientation:(CHToastAppearOrientation)orientation {
    // prepare toast display label
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    CGSize boundingRectSize = CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 120,
                                         CGRectGetHeight([[UIScreen mainScreen] bounds]));
    CGSize size = [message boundingRectWithSize:boundingRectSize
                                        options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size;
    PaddingLabel *toastLabel = [PaddingLabel new];
    toastLabel.bounds = CGRectMake(0, 0, size.width + 20, size.height + 20);
    toastLabel.backgroundColor = [UIColor whiteColor];
    toastLabel.textColor = [UIColor darkTextColor];
    toastLabel.textAlignment = NSTextAlignmentLeft;
    toastLabel.numberOfLines = 0;
    toastLabel.layer.cornerRadius = 4;
    toastLabel.layer.masksToBounds = YES;
    toastLabel.font = font;
    toastLabel.text = message;
    
    // toast can display on top of keyboard
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:toastLabel];

    // prepare animations
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (orientation == CHToastAppearOrientationTop) {
        toastLabel.center = CGPointMake(bounds.size.width / 2 , -toastLabel.bounds.size.height);
    } else if (orientation == CHToastAppearOrientationBottom) {
        toastLabel.center = CGPointMake(bounds.size.width / 2 , bounds.size.height + toastLabel.bounds.size.height);
    }
    
    // define animatins blocks
    void (^animations)() = ^{
        CGFloat toastLabelCenterY = 0;
        if (orientation == CHToastAppearOrientationTop) {
            toastLabelCenterY = CGRectGetMinY(toastLabel.superview.frame) + 40 + CGRectGetMidY(toastLabel.bounds);
        } else if (orientation == CHToastAppearOrientationBottom) {
            toastLabelCenterY = CGRectGetMaxY(toastLabel.superview.frame) - 120 - CGRectGetMidY(toastLabel.bounds);
        }
        toastLabel.center = CGPointMake(bounds.size.width / 2 , toastLabelCenterY);
    };
    void (^completion)(BOOL finished) = ^(BOOL finished) {
        [UIView animateWithDuration:kAnimationDuration
                              delay:kDelayDuration
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             toastLabel.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             [toastLabel removeFromSuperview];
                         }];
    };
    
    // run animatons
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:animations
                     completion:completion];
}

// 吐司框，自动消失
+ (void)toastWithMessage:(NSString *)message {
    [self toastWithMessage:message appearOrientation:CHToastAppearOrientationBottom];
}



@end
