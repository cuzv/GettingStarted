//
//  GapRing.h
//  GettingStarted
//
//  Created by Moch Xiao on 11/2/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHXGapRing : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, readonly, getter = isAnimating) BOOL animating;

- (void)startAnimation;
- (void)stopAnimation;

@end
