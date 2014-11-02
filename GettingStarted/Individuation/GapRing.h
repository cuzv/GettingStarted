//
//  GapRing.h
//  GettingStarted
//
//  Created by Moch on 11/2/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GapRing : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, readonly, getter = isAnimating) BOOL animating;

- (void)startAnimation;
- (void)stopAnimation;

@end
