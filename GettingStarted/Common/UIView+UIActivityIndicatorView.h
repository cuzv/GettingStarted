//
//  UIView+UIActivityIndicatorView.h
//  GettingStarted
//
//  Created by Moch on 8/25/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIActivityIndicatorView)

- (void)addActivityIndicatorAnimation;
- (void)addActivityIndicatorAnimationWithStyle:(UIActivityIndicatorViewStyle)style;
- (void)removeActivityIndicatorAnimation;

@end
