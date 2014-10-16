//
//  UIView+GradientCircularProgress.m
//  GettingStarted
//
//  Created by Moch on 10/16/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIView+GradientCircularProgress.h"
#import "GradientCircularProgress.h"
#import <objc/runtime.h>

static const void *GradientCircularProgressKey = &GradientCircularProgressKey;

@interface UIView ()
@property(nonatomic, weak) GradientCircularProgress *gradientCircularProgress;
@end

@implementation UIView (GradientCircularProgress)

- (void)setGradientCircularProgress:(GradientCircularProgress *)gradientCircularProgress {
    [self willChangeValueForKey:@"GradientCircularProgressKey"];
    objc_setAssociatedObject(self, GradientCircularProgressKey, gradientCircularProgress, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"GradientCircularProgressKey"];
}

- (GradientCircularProgress *)gradientCircularProgress {
    return objc_getAssociatedObject(self, &GradientCircularProgressKey);
}

- (void)addGradientCircularProgressAnimation {
    [self addGradientCircularProgressAnimationOnCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
}

- (void)addGradientCircularProgressAnimationOnCenter:(CGPoint)center {
    if (self.gradientCircularProgress) {
        return;
    }
    
    GradientCircularProgress *gradientCircularProgress = [[GradientCircularProgress alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    gradientCircularProgress.center = center;
    self.gradientCircularProgress = gradientCircularProgress;
    [self addSubview:gradientCircularProgress];
    [gradientCircularProgress startRotation];
}


- (void)removeGradientCircularProgressAnimation {
    [self.gradientCircularProgress stopRotation];
    [self.gradientCircularProgress removeFromSuperview];
    self.gradientCircularProgress = nil;
}

@end
