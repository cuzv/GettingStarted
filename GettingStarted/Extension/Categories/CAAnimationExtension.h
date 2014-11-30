//
//  CAAnimationExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 11/30/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CAAnimationExtension : NSObject

@end

#pragma mark - 生成动画

@interface CAAnimation (CHXGenerate)

/**
 *  pingpang animation
 *
 *  @param animations animations
 *
 *  @return CAAnimationGroup
 */
+ (CAAnimationGroup *)chx_loadingAnimationGroup:(NSArray *)animations;

// for PingPang
+ (CAKeyframeAnimation *)chx_loadingPositionXAnimation;

// for PingPang
+ (CAKeyframeAnimation *)chx_loadingPositionYAnimation;

// scale
+ (CAKeyframeAnimation *)chx_loadingScaleAnimation;

+ (CABasicAnimation *)chx_opacityFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue;

+ (CABasicAnimation *)chx_rotationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue;

+ (CABasicAnimation *)chx_translationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue;


@end