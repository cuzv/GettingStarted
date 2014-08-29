//
//  UIScrollView+Accessor.h
//  GettingStarted
//
//  Created by Moch on 8/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Accessor)

@property (assign, nonatomic) CGFloat contentInsetTop;
@property (assign, nonatomic) CGFloat contentInsetBottom;
@property (assign, nonatomic) CGFloat contentInsetLeft;
@property (assign, nonatomic) CGFloat contentInsetRight;

@property (assign, nonatomic) CGFloat contentOffsetX;
@property (assign, nonatomic) CGFloat contentOffsetY;

@property (assign, nonatomic) CGFloat contentSizeWidth;
@property (assign, nonatomic) CGFloat contentSizeHeight;

@end
