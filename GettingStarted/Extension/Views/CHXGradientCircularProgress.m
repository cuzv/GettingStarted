//
//  CHXGradientCircularProgress.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
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

#import "CHXGradientCircularProgress.h"
#import "CHXGlobalServices.h"

#define kGradientCircularProgressAnimationDuration 0.6f
#define kDefaultCircluarWidth 2.0f

@interface CHXGradientCircularProgress ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) NSUInteger percent;
@property (nonatomic, assign) BOOL sevenColorRing;
@property (nonatomic, assign) BOOL resetAnimation;
@property (nonatomic, readwrite, getter = isAnimating) BOOL animating;
@property (nonatomic, assign, getter = isInitializeTime) BOOL initializeTime;


@end

@implementation CHXGradientCircularProgress

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (!newSuperview) {
        self.resetAnimation = NO;
        [self pr_stopRotateAnimation];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    
    if (self.isInitializeTime) {
        self.initializeTime = NO;
        return;
    }
    
    if (newWindow) {
        [self startAnimation];
    } else {
        self.resetAnimation = NO;
        [self stopAnimation];
    }
}

- (instancetype)initWithSevenColorRingFrame:(CGRect )frame {
    _sevenColorRing = YES;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame
                    trackColor:nil
                 progressColor:[UIColor lightGrayColor]
                 circluarWidth:kDefaultCircluarWidth];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self pr_drewViewWithTrackColor:nil
                          progressColor:[UIColor lightGrayColor]
                          circluarWidth:kDefaultCircluarWidth];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                   trackColor:(UIColor *)trackColor
                progressColor:(UIColor *)progressColor
                circluarWidth:(CGFloat)circluarWidth {
    CGRect newFrame = CGRectMake(frame.origin.x,
                                 frame.origin.y,
                                 MIN(CGRectGetWidth(frame), CGRectGetHeight(frame)),
                                 MIN(CGRectGetWidth(frame), CGRectGetHeight(frame)));
    if (self = [super initWithFrame:newFrame]) {
        [self pr_drewViewWithTrackColor:trackColor
                          progressColor:progressColor
                          circluarWidth:circluarWidth];
    }
    
    return self;
}

- (void)pr_drewViewWithTrackColor:(UIColor *)trackColor
                    progressColor:(UIColor *)progressColor
                    circluarWidth:(CGFloat)circluarWidth {
    self.resetAnimation = YES;
    // 裁剪为圆形
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2;
    self.layer.masksToBounds = YES;
    
    // 创建 track 路径
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                                                             radius:(CGRectGetWidth(self.bounds) - circluarWidth) / 2
                                                         startAngle:chx_radianFromAngle(0)
                                                           endAngle:chx_radianFromAngle(360)
                                                          clockwise:YES];
    // 创建一个track shape layer
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = self.bounds;
    trackLayer.fillColor = [[UIColor clearColor] CGColor];
    // 指定 path 的渲染颜色
    trackLayer.strokeColor = [trackColor CGColor];
    // 背景透明度
    trackLayer.opacity = 0.5;
    // 指定线的边缘是圆的
    trackLayer.lineCap = kCALineCapRound;
    // 线的宽度
    trackLayer.lineWidth = circluarWidth;
    trackLayer.path = [trackPath CGPath];
    trackLayer.strokeEnd = 1;
    [self.layer addSublayer:trackLayer];
    
    // 构建圆弧
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                                                        radius:(CGRectGetWidth(self.bounds) - circluarWidth) / 2
                                                    startAngle:chx_radianFromAngle(95)
                                                      endAngle:chx_radianFromAngle(445 + (_sevenColorRing ? 10 : 0))
                                                     clockwise:YES];
    // 进度条
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [progressColor CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.opaque = 0.5;
    _progressLayer.lineWidth = circluarWidth;
    _progressLayer.path = [path CGPath];
    _progressLayer.strokeEnd = 1;
    
    // left gradient layer
    CAGradientLayer *leftGradientLayer =  [CAGradientLayer layer];
    leftGradientLayer.frame = CGRectMake(0, 0, CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds));
    leftGradientLayer.colors = _sevenColorRing ? [self pr_gradientColorRefs] : [self pr_leftGradientColorRefs:progressColor];
    leftGradientLayer.startPoint = CGPointMake(0.5, 1);
    leftGradientLayer.endPoint = CGPointMake(0.5, 0);
    
    // right gradient layer
    CAGradientLayer *rightGradientLayer =  [CAGradientLayer layer];
    // right GradientLayer.locations = @[@0.1, @0.5, @1];
    rightGradientLayer.frame = CGRectMake(CGRectGetMidX(self.bounds), 0, CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds));
    rightGradientLayer.colors = _sevenColorRing ? [[[self pr_gradientColorRefs] reverseObjectEnumerator] allObjects] : [self pr_rightGradientColorRefs:progressColor];
    rightGradientLayer.startPoint = CGPointMake(0.5, 0);
    rightGradientLayer.endPoint = CGPointMake(0.5, 1);
    
    // gradient layer
    CALayer *gradientLayer = [CALayer layer];
    [gradientLayer addSublayer:leftGradientLayer];
    [gradientLayer addSublayer:rightGradientLayer];
    
    // 用progressLayer来截取渐变层
    gradientLayer.mask = _progressLayer;
    [self.layer addSublayer:gradientLayer];
    
    [self updatePercent:100 animated:NO];
}

- (NSArray *)pr_gradientColorRefs {
    NSMutableArray *colorRefs = [NSMutableArray new];
    
    CGColorRef red = [[UIColor redColor] CGColor];
    [colorRefs addObject:(__bridge id)(red)];
    CGColorRef oranger = [[UIColor orangeColor] CGColor];
    [colorRefs addObject:(__bridge id)(oranger)];
    CGColorRef yellow = [[UIColor yellowColor] CGColor];
    [colorRefs addObject:(__bridge id)(yellow)];
    CGColorRef green = [[UIColor greenColor] CGColor];
    [colorRefs addObject:(__bridge id)(green)];
    CGColorRef cyan = [[UIColor cyanColor] CGColor];
    [colorRefs addObject:(__bridge id)(cyan)];
    CGColorRef blue = [[UIColor blueColor] CGColor];
    [colorRefs addObject:(__bridge id)(blue)];
    CGColorRef purple = [[UIColor purpleColor] CGColor];
    [colorRefs addObject:(__bridge id)(purple)];
    
    return [NSArray arrayWithArray:colorRefs];
}

- (NSArray *)pr_leftGradientColorRefs:(UIColor *)aColor {
    CGColorRef transparentColor = [[aColor colorWithAlphaComponent:0] CGColor];
    CGColorRef shadowColor = [[aColor colorWithAlphaComponent:0.5] CGColor];
    return @[(__bridge id)transparentColor, (__bridge id)shadowColor];
}

- (NSArray *)pr_rightGradientColorRefs:(UIColor *)aColor {
    CGColorRef shadowColor = [[aColor colorWithAlphaComponent:0.5] CGColor];
    CGColorRef originColor = [aColor CGColor];
    return @[(__bridge id)shadowColor, (__bridge id)originColor];
}

- (void)updatePercent:(NSUInteger)percent animated:(BOOL)animated {
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:kGradientCircularProgressAnimationDuration / 3];
    _progressLayer.strokeEnd = percent / 100.0f;
    [CATransaction commit];
    
    _percent = percent;
}

- (void)startAnimation {
    if (self.isAnimating) {
        return;
    }
    
    [self pr_startRotateAnimation];
    
    self.animating = YES;
}

- (void)pr_startRotateAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.duration = kGradientCircularProgressAnimationDuration;
    basicAnimation.repeatCount = HUGE_VAL;
    basicAnimation.fromValue = 0;
    basicAnimation.toValue = @(2 * M_PI);
    basicAnimation.removedOnCompletion = YES;
    basicAnimation.delegate = self;
    [self.layer addAnimation:basicAnimation forKey:@"rotationZ"];
}

- (void)stopAnimation {
    if (!self.animating) {
        return;
    }
    
    [self pr_stopRotateAnimation];
    
    self.animating = NO;
}

- (void)pr_stopRotateAnimation {
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.layer removeAllAnimations];
        self.alpha = 1;
    }];
}

- (BOOL)isInAnimation {
    return self.animating;
}

// animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!self.animating) {
        return;
    }
    
    if (!flag && self.resetAnimation) {
        [self startAnimation];
    }
}

@end


#pragma mark - 为视图添加渐变环形进度指示器

#import <objc/runtime.h>
#import "CHXGradientCircularProgress.h"

static const void *GradientCircularProgressKey = &GradientCircularProgressKey;

@implementation UIView (CHXGradientCircularProgress)

- (void)pr_setGradientCircularProgress:(CHXGradientCircularProgress *)gradientCircularProgress {
    [self willChangeValueForKey:@"GradientCircularProgressKey"];
    objc_setAssociatedObject(self, &GradientCircularProgressKey, gradientCircularProgress, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"GradientCircularProgressKey"];
}

- (CHXGradientCircularProgress *)pr_gradientCircularProgress {
    return objc_getAssociatedObject(self, &GradientCircularProgressKey);
}

- (void)chx_addGradientCircularProgressAnimation {
    [self chx_addGradientCircularProgressAnimationOnCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
}

- (void)chx_addGradientCircularProgressAnimationOnCenter:(CGPoint)center {
    if ([self pr_gradientCircularProgress]) {
        return;
    }
    
    CHXGradientCircularProgress *gradientCircularProgress = [[CHXGradientCircularProgress alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    gradientCircularProgress.center = center;
    [self pr_setGradientCircularProgress:gradientCircularProgress];
    [self addSubview:gradientCircularProgress];
    [gradientCircularProgress startAnimation];
}


- (void)chx_removeGradientCircularProgressAnimation {
    [[self pr_gradientCircularProgress] stopAnimation];
    [[self pr_gradientCircularProgress] removeFromSuperview];
    [self pr_setGradientCircularProgress:nil];
}

@end


