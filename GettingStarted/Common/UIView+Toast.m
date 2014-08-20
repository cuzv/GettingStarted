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

@implementation UIView (Toast)

// 吐司框，自动消失
+ (void)toastWithMessage:(NSString *)message {
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    CGSize boundingRectSize = CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 120,
                                         CGRectGetHeight([[UIScreen mainScreen] bounds]));
    CGSize size = [message boundingRectWithSize:boundingRectSize
                                        options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size;
    __block PaddingLabel *toastLabel = [[PaddingLabel alloc] init];
    toastLabel.bounds = CGRectMake(0, 0, size.width + 20, size.height + 20);
    CGRect bounds = [[UIScreen mainScreen] bounds];
    toastLabel.backgroundColor = [UIColor whiteColor];
    toastLabel.textColor = [UIColor darkTextColor];
    toastLabel.textAlignment = NSTextAlignmentLeft;
    toastLabel.numberOfLines = 0;
    toastLabel.layer.cornerRadius = 4;
    toastLabel.layer.masksToBounds = YES;
    toastLabel.font = font;
    toastLabel.text = message;
    
    // 实现可以让toast显示在键盘上方
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:toastLabel];
    
    toastLabel.center = CGPointMake(bounds.size.width / 2 , bounds.size.height * 2);
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toastLabel.center = CGPointMake(bounds.size.width / 2 , CGRectGetMaxY(toastLabel.superview.frame)
                                                         - 120 - CGRectGetHeight(toastLabel.bounds) / 2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:kDelayDuration
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              toastLabel.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                              [toastLabel removeFromSuperview];
                                              toastLabel = nil;
                                          }];
                     }];


}

@end
