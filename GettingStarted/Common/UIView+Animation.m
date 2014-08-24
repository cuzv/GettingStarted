//
//  UIView+Animation.m
//  GettingStarted
//
//  Created by Moch on 8/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIView+Animation.h"
#define kVerticalDistanceForEdges 80

@implementation UIView (Animation)

- (void)shakeWithOrientation:(CHAnimationOrientation)orientation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = orientation == CHToastAppearOrientationHorizontal ? @"position.x" : @"position.y";
    animation.values = @[@0, @10, @-10, @10, @0];
    animation.keyTimes = @[@0, @(1 / 6.0f), @(3 / 6.0f), @(5 / 6.0f), @1];
    animation.duration = 0.4;
    animation.additive = YES;
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)shake {
    [self shakeWithOrientation:CHToastAppearOrientationHorizontal];
}

- (void)shakeForToastAppearOrientation:(CHToastAppearOrientation)orientation {
    CGFloat verticalMovingValue = self.height + kVerticalDistanceForEdges;
    verticalMovingValue = orientation == CHToastAppearOrientationBottom ? verticalMovingValue: -verticalMovingValue;
    CGFloat verticalMovingFixedValue = -20;
    verticalMovingFixedValue = orientation == CHToastAppearOrientationBottom ? verticalMovingFixedValue : -verticalMovingFixedValue;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.y";
    animation.values = @[@0, @(verticalMovingValue), @(verticalMovingFixedValue), @0];
    animation.keyTimes = @[@0, @0, @(2 / 3.0f), @1];
    animation.duration = 0.4;
    animation.additive = YES;
    [self.layer addAnimation:animation forKey:@"shake"];
}

@end
