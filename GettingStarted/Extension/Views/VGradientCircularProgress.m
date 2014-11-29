//
//  GradientCircularProgress.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "VGradientCircularProgress.h"
#import "VGlobalServices.h"

#define kGradientCircularProgressAnimationDuration 1.0f
#define kDefaultCircluarWidth 2.0f

@interface VGradientCircularProgress ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) NSUInteger percent;
@property (nonatomic, assign) BOOL sevenColorRing;
@property (nonatomic, assign) BOOL resetAnimation;
@property (nonatomic, readwrite, getter = isAnimating) BOOL animating;
@property (nonatomic, assign, getter = isInitializeTime) BOOL initializeTime;


@end

@implementation VGradientCircularProgress

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (!newSuperview) {
        self.resetAnimation = NO;
        [self stopRotateAnimation];
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
        [self drewViewWithTrackColor:nil
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
        [self drewViewWithTrackColor:trackColor
                       progressColor:progressColor
                       circluarWidth:circluarWidth];
    }
    
    return self;
}

- (void)drewViewWithTrackColor:(UIColor *)trackColor
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
                                                         startAngle:radianFromAngle(0)
                                                           endAngle:radianFromAngle(360)
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
                                                    startAngle:radianFromAngle(95)
                                                      endAngle:radianFromAngle(445 + (_sevenColorRing ? 10 : 0))
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
    _progressLayer.strokeEnd = 0;
    
    // left gradient layer
    CAGradientLayer *leftGradientLayer =  [CAGradientLayer layer];
    leftGradientLayer.frame = CGRectMake(0, 0, CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds));
    leftGradientLayer.colors = _sevenColorRing ? [self gradientColorRefs] : [self leftGradientColorRefs:progressColor];
    leftGradientLayer.startPoint = CGPointMake(0.5, 1);
    leftGradientLayer.endPoint = CGPointMake(0.5, 0);
    
    // right gradient layer
    CAGradientLayer *rightGradientLayer =  [CAGradientLayer layer];
    // right GradientLayer.locations = @[@0.1, @0.5, @1];
    rightGradientLayer.frame = CGRectMake(CGRectGetMidX(self.bounds), 0, CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds));
    rightGradientLayer.colors = _sevenColorRing ? [[[self gradientColorRefs] reverseObjectEnumerator] allObjects] : [self rightGradientColorRefs:progressColor];
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

- (NSArray *)gradientColorRefs {
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

- (NSArray *)leftGradientColorRefs:(UIColor *)aColor {
    CGColorRef transparentColor = [[aColor colorWithAlphaComponent:0] CGColor];
    CGColorRef shadowColor = [[aColor colorWithAlphaComponent:0.5] CGColor];
    return @[(__bridge id)transparentColor, (__bridge id)shadowColor];
}

- (NSArray *)rightGradientColorRefs:(UIColor *)aColor {
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
    
    [self startRotateAnimation];
    
    self.animating = YES;
}

- (void)startRotateAnimation {
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
    
    [self stopRotateAnimation];
    
    self.animating = NO;
}

- (void)stopRotateAnimation {
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
