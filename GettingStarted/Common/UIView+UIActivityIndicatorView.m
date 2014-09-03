//
//  UIView+UIActivityIndicatorView.m
//  GettingStarted
//
//  Created by Moch on 8/25/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIView+UIActivityIndicatorView.h"
#import <objc/runtime.h>

static const void *ActivityIndicatorViewKey = &ActivityIndicatorViewKey;

@interface UIView ()
@property(nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation UIView (UIActivityIndicatorView)

- (void)setActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView {
    [self willChangeValueForKey:@"ActivityIndicatorViewKey"];
    objc_setAssociatedObject(self, ActivityIndicatorViewKey, activityIndicatorView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ActivityIndicatorViewKey"];
}

- (UIActivityIndicatorView *)activityIndicatorView {
    return objc_getAssociatedObject(self, &ActivityIndicatorViewKey);
}

- (void)addActivityIndicatorAnimation {
    [self addActivityIndicatorAnimationWithStyle:UIActivityIndicatorViewStyleWhiteLarge];
}

- (void)addActivityIndicatorAnimationWithStyle:(UIActivityIndicatorViewStyle)style {
    if (self.activityIndicatorView) {
        return;
    }

    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    activityIndicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    activityIndicatorView.color = [UIColor lightGrayColor];
    self.activityIndicatorView = activityIndicatorView;
    [self addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

- (void)removeActivityIndicatorAnimation {
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    self.activityIndicatorView = nil;
}

@end
