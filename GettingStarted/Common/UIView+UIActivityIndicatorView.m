//
//  UIView+UIActivityIndicatorView.m
//  GettingStarted
//
//  Created by Moch on 8/25/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIView+UIActivityIndicatorView.h"
#define kActivityIndicatorViewTag 400

@implementation UIView (UIActivityIndicatorView)

- (void)addActivityIndicatorAnimation {
    [self addActivityIndicatorAnimationWithStyle:UIActivityIndicatorViewStyleWhiteLarge];
}

- (void)addActivityIndicatorAnimationWithStyle:(UIActivityIndicatorViewStyle)style {
    for (UIView *subView in self.subviews) {
        if (subView.tag == kActivityIndicatorViewTag) {
            return;
        }
    }

    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    activityIndicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    activityIndicatorView.color = [UIColor lightGrayColor];
    activityIndicatorView.tag = kActivityIndicatorViewTag;
    [self addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

- (void)removeActivityIndicatorAnimation {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *subView = obj;
        BOOL isActivityIndicatorView = [subView isMemberOfClass:[UIActivityIndicatorView class]] && subView.tag == kActivityIndicatorViewTag;
        if (isActivityIndicatorView) {
            UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)subView;
            [activityIndicatorView stopAnimating];
            [activityIndicatorView removeFromSuperview];
            activityIndicatorView = nil;
        }
    }];
}

@end
