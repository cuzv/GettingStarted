//
//  CAAnimationExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-30.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CAAnimationExtension.h"

@implementation CAAnimationExtension

@end


#pragma mark - 生成动画

@implementation CAAnimation (CHXGenerate)

#define kLoadingAnimationDuration 3
// for PingPang
+ (CAAnimationGroup *)chx_loadingAnimationGroup:(NSArray *)animations {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = kLoadingAnimationDuration;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.animations = animations;
    animationGroup.repeatCount = HUGE_VAL;
    return animationGroup;
}

// for PingPang
+ (CAKeyframeAnimation *)chx_loadingPositionXAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.duration = kLoadingAnimationDuration;
    animation.repeatCount = HUGE_VALF;
    animation.keyPath = @"position.x";
    animation.values = @[@0, @-30, @0, @30, @0, @-30];
    animation.keyTimes = @[@0, @0, @(1 / 4.0f), @(2 / 4.0f), @(3 / 4.0f), @1];
    // this is import!!!
    animation.additive = YES;
    return animation;
}

// for PingPang
+ (CAKeyframeAnimation *)chx_loadingPositionYAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.duration = kLoadingAnimationDuration;
    animation.repeatCount = HUGE_VALF;
    animation.keyPath = @"position.y";
    animation.values = @[@0, @0, @10, @0, @-10, @0];
    animation.keyTimes = @[@0, @0, @(1 / 4.0f), @(2 / 4.0f), @(3 / 4.0f), @1];
    // this is import!!!
    animation.additive = YES;
    return animation;
}

+ (CAKeyframeAnimation *)chx_loadingScaleAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@0.7, @0.7, @1.3, @0.7, @0.5, @0.7];
    animation.keyTimes = @[@0, @0, @(1 / 4.0f), @(2 / 4.0f), @(3 / 4.0f), @1];
    animation.duration = kLoadingAnimationDuration;
    animation.repeatCount = HUGE_VALF;
    return animation;
}

+ (CABasicAnimation *)chx_opacityFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    return animation;
}

+ (CABasicAnimation *)chx_rotationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    return animation;
}

+ (CABasicAnimation *)chx_translationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.5f;
    // 动画延迟时间
    //    animation.beginTime = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    return animation;
}


@end