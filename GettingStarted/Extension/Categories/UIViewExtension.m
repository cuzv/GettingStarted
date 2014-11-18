//
//  UIViewExtension.m
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIViewExtension.h"

@implementation UIViewExtension
@end

#pragma mark -
#pragma mark - 类别

#pragma mark - 视图框架访问器方法

@implementation UIView (Accessor)

- (void)setOrigin:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.minX, self.minY, size.width, size.height);
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setMinX:(CGFloat)x {
    self.frame = CGRectMake(x, self.minY, self.width, self.height);
}

- (CGFloat)minX {
    return self.frame.origin.x;
}

- (void)setMidX:(CGFloat)x {
    self.frame = CGRectMake(x - self.width / 2, self.minY, self.width, self.height);
}

- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

- (void)setMaxX:(CGFloat)x {
    self.frame = CGRectMake(x - self.width, self.minY, self.width, self.height);
}

- (CGFloat)maxX {
    return self.minX + self.width;
}

- (void)setMinY:(CGFloat)y {
    self.frame = CGRectMake(self.minX, y, self.width, self.height);
}

- (CGFloat)minY {
    return self.frame.origin.y;
}

- (void)setMidY:(CGFloat)y {
    self.frame = CGRectMake(self.minX, y - self.height / 2, self.width, self.height);
}

- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}

- (void)setMaxY:(CGFloat)y {
    self.frame = CGRectMake(self.minX, y - self.height, self.width, self.height);
}

- (CGFloat)maxY {
    return self.minY + self.height;
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.minX, self.minY, width, self.height);
}

- (CGFloat)width {
    return CGRectGetWidth(self.bounds);
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.minX, self.minY, self.width, height);
}

- (CGFloat)height {
    return CGRectGetHeight(self.bounds);
}

@end

#pragma mark - 为视图添加动画

@implementation UIView (Animation)

#define kLoadingAnimationDuration 3
// for PingPang
+ (CAAnimationGroup *)loadingAnimationGroup:(NSArray *)animations {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = kLoadingAnimationDuration;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationGroup.animations = animations;
    animationGroup.repeatCount = HUGE_VAL;
    return animationGroup;
}

// for PingPang
+ (CAKeyframeAnimation *)loadingPositionXAnimation {
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
+ (CAKeyframeAnimation *)loadingPositionYAnimation {
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

+ (CAKeyframeAnimation *)loadingScaleAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@0.7, @0.7, @1.3, @0.7, @0.5, @0.7];
    animation.keyTimes = @[@0, @0, @(1 / 4.0f), @(2 / 4.0f), @(3 / 4.0f), @1];
    animation.duration = kLoadingAnimationDuration;
    animation.repeatCount = HUGE_VALF;
    return animation;
}

+ (CABasicAnimation *)opacityFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    return animation;
}

+ (CABasicAnimation *)rotationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    return animation;
}

+ (CABasicAnimation *)translationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue {
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


#pragma mark - 添加环形动画

#import <objc/runtime.h>

@interface UIView ()
@property (nonatomic, weak) CAShapeLayer *arcLayer;
@end

@implementation UIView (ArcRotationAnimation)

static const void *ArcLayerKey = &ArcLayerKey;
- (void)setArcLayer:(CAShapeLayer *)arcLayer {
    [self willChangeValueForKey:@"ArcLayerKey"];
    objc_setAssociatedObject(self, ArcLayerKey, arcLayer, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ArcLayerKey"];
}

- (CAShapeLayer *)arcLayer {
    return objc_getAssociatedObject(self, &ArcLayerKey);
}

- (void)addArcShapeLayerWithColor:(UIColor *)strokeColor {
    [self.layer addSublayer:[self arcShapeLayerWithColor:strokeColor]];
}

- (CAShapeLayer *)arcShapeLayerWithColor:(UIColor *)strokeColor {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rect = self.bounds;
    CGFloat half = MIN(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [path addArcWithCenter:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
                    radius:half
                startAngle:2 * M_PI - M_PI_2
                  endAngle:-M_PI_2
                 clockwise:YES];
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.path = path.CGPath;
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = [strokeColor CGColor] ? : [[UIColor lightGrayColor] CGColor];
    arcLayer.lineWidth = 2;
    arcLayer.frame = rect;
    
    return arcLayer;
}

- (void)addArcRotationAnimaionWithDuration:(NSTimeInterval)duration {
    [self addArcRotationAnimaionWithDuration:duration lineColor:[UIColor blueColor]];
}

- (void)addArcRotationAnimaionWithDuration:(NSTimeInterval)duration lineColor:(UIColor *)color {
    if (self.arcLayer) {
        return;
    }
    // 添加 layer
    CAShapeLayer *arcLayer = [self arcShapeLayerWithColor:color];
    self.arcLayer = arcLayer;
    [self.layer addSublayer:arcLayer];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithInteger:0];
    animation.toValue = [NSNumber numberWithInteger:1];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    [arcLayer addAnimation:animation forKey:@"animation"];
}

- (void)removeArcRotationAnimation {
    [self.arcLayer removeAllAnimations];
    [self.arcLayer removeFromSuperlayer];
    self.arcLayer = nil;
}

@end


#pragma mark - 为视图添加振动动画效果
@implementation UIView (ShakeAnimation)

- (void)shake {
    [self shakeWithOrientation:CHAnimationOrientationHorizontal];
}

- (void)shakeWithOrientation:(CHAnimationOrientation)orientation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = orientation == CHAnimationOrientationHorizontal ? @"position.x" : @"position.y";
    animation.values = @[@0, @10, @-10, @10, @0];
    animation.keyTimes = @[@0, @(1 / 6.0f), @(3 / 6.0f), @(5 / 6.0f), @1];
    animation.duration = 0.4;
    animation.additive = YES;
    [self.layer addAnimation:animation forKey:@"shake"];
}

#define kBottomVerticalDistanceForEdges 80
#define kTopVerticalDistanceForEdges 65
- (void)shakeForToastAppearOrientation:(CHToastAppearOrientation)orientation {
    CGFloat verticalMovingValue = self.height + orientation == CHToastAppearOrientationBottom ? kBottomVerticalDistanceForEdges : kTopVerticalDistanceForEdges;
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

#pragma mark - 加载动画效果(打乒乓球效果)

@implementation UIView (PingPang)

- (void)addLoadingAnimation {
    [self addLoadingAnimationWitchColor:[UIColor whiteColor]];
}

#define kCircleTag 300
- (void)addLoadingAnimationWitchColor:(UIColor *)color {
    if (self.frame.size.width < 80) {
        NSLog(@"can not add this animation for view which width < 80");
        return;
    }
    
    NSMutableArray *circles = [NSMutableArray new];
    for (NSInteger i = 0; i < 3; i++) {
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds),
                                                                  CGRectGetMidY(self.bounds), 20, 20)];
        circle.backgroundColor = color;
        circle.layer.cornerRadius = 10;
        circle.layer.masksToBounds = YES;
        circle.tag = kCircleTag + i;
        [circles addObject:circle];
    }
    
    CAKeyframeAnimation *positionXAnimation = [UIView loadingPositionXAnimation];
    CAKeyframeAnimation *positionYAnimation = [UIView loadingPositionYAnimation];
    CAKeyframeAnimation *scaleAnimation = [UIView loadingScaleAnimation];
    CAAnimationGroup *loadingAnimationGroup = [UIView loadingAnimationGroup:@[positionXAnimation, scaleAnimation, positionYAnimation]];
    
    [self addSubview:circles[0]];
    [[circles[0] layer] addAnimation:loadingAnimationGroup forKey:@"loadingAnimationGroup"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CACurrentMediaTime() + loadingAnimationGroup.duration * 1 / 3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addSubview:circles[1]];
        [[circles[1] layer] addAnimation:loadingAnimationGroup forKey:@"loadingAnimationGroup"];
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CACurrentMediaTime() + loadingAnimationGroup.duration * 2 / 3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addSubview:circles[2]];
        [[circles[2] layer] addAnimation:loadingAnimationGroup forKey:@"loadingAnimationGroup"];
    });
}

- (void)removeLoadingAnimation {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *subView = obj;
        if (subView.tag == kCircleTag ||
            subView.tag == kCircleTag + 1 ||
            subView.tag == kCircleTag + 2) {
            [subView.layer removeAllAnimations];
            [subView removeFromSuperview];
            subView = nil;
        }
    }];
}

@end




#pragma mark -  吐司框效果

#import "PaddingLabel.h"
#import "NSStringExtension.h"

#define kDelayDuration 1.5
#define kHorizontalDistanceForEdges 60

@implementation UIView (Toast)

+ (void)toastWithMessage:(NSString *)message
       appearOrientation:(CHToastAppearOrientation)orientation {
    if (!message.length) {
        return;
    }
    
    // prepare toast display label
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    CGSize size = [message sizeWithFont:font width:CGRectGetWidth([[UIScreen mainScreen] bounds]) - kHorizontalDistanceForEdges * 2];
    PaddingLabel *toastLabel = [PaddingLabel new];
    CGFloat paddingEdgeInsetsSideLength = toastLabel.edgeInsets.left + toastLabel.edgeInsets.right;
    toastLabel.bounds = CGRectMake(0, 0, size.width + paddingEdgeInsetsSideLength, size.height + paddingEdgeInsetsSideLength);
    toastLabel.backgroundColor = [UIColor blackColor];
    toastLabel.textColor = [UIColor whiteColor];
    toastLabel.textAlignment = NSTextAlignmentLeft;
    toastLabel.contentMode = UIViewContentModeCenter;
    toastLabel.numberOfLines = 0;
    toastLabel.layer.cornerRadius = 5;
    toastLabel.layer.masksToBounds = YES;
    toastLabel.font = font;
    toastLabel.text = message;
    // resolve label right edge hava a gray line problem
    [toastLabel setBorderLineColor:toastLabel.backgroundColor];
    // toast can display on top of keyboard
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:toastLabel];
    
    // prepare animations
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (orientation == CHToastAppearOrientationTop) {
        toastLabel.center = CGPointMake(bounds.size.width / 2 , CGRectGetMidY(toastLabel.bounds) + kTopVerticalDistanceForEdges);
    } else if (orientation == CHToastAppearOrientationBottom) {
        toastLabel.center = CGPointMake(bounds.size.width / 2 , bounds.size.height - toastLabel.bounds.size.height - kBottomVerticalDistanceForEdges);
    }
    
    // run animation
    [toastLabel shakeForToastAppearOrientation:orientation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            toastLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [toastLabel removeFromSuperview];
        }];
    });
}

+ (void)toastWithMessage:(NSString *)message {
    [self toastWithMessage:message appearOrientation:CHToastAppearOrientationTop];
}

- (void)makeToast:(NSString *)message {
    __block UIView *backgroundView = [UIView new];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    backgroundView.layer.cornerRadius = 10;
    backgroundView.layer.masksToBounds = YES;
    __block UILabel *toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 400)];
    toastLabel.text = message;
    toastLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    toastLabel.numberOfLines = 0;
    [toastLabel sizeToFit];
    toastLabel.alpha = 0;
    [backgroundView addSubview:toastLabel];
    CGFloat toastWidth = CGRectGetWidth(toastLabel.bounds) + 40;
    toastWidth = toastWidth < 260 ? toastWidth : 260;
    CGFloat toastHeight = CGRectGetHeight(toastLabel.bounds) + 40;
    toastHeight = toastHeight > 80 ? toastHeight : 80;
    backgroundView.bounds = CGRectMake(0, 0, toastWidth, toastHeight);
    CGFloat toastMidX = CGRectGetWidth(self.bounds) / 2;
    CGFloat toastMidY = CGRectGetHeight(self.bounds) / 2;
    toastMidY = [UIView isKeyBoardInDisplay] ? toastMidY - 60 : toastMidY;
    backgroundView.center = CGPointMake(toastMidX, toastMidY);
    toastLabel.center = CGPointMake(CGRectGetMidX(backgroundView.bounds),
                                    CGRectGetMidY(backgroundView.bounds));
    [backgroundView blur];
    [self addSubview:backgroundView];
    [UIView animateWithDuration:0.5 animations:^{
        toastLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:2 options:0 animations:^{
            toastLabel.alpha = 0;
            backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [toastLabel removeFromSuperview];
            toastLabel = nil;
            [backgroundView removeFromSuperview];
            backgroundView = nil;
        }];
    }];
}

+ (BOOL)isKeyBoardInDisplay {
    BOOL isExists = NO;
    for (UIWindow *keyboardWindow in [[UIApplication sharedApplication] windows])   {
        if ([[keyboardWindow description] hasPrefix:@"<UITextEffectsWindow"] == YES) {
            isExists = YES;
        }
    }
    
    return isExists;
}

@end


#pragma mark - 为视图添加进度指示器

#import <objc/runtime.h>

static const void *ActivityIndicatorViewKey = &ActivityIndicatorViewKey;

@interface UIView ()
@property(nonatomic, weak, readwrite) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation UIView (UIActivityIndicatorView)

- (void)setActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView {
    [self willChangeValueForKey:@"ActivityIndicatorViewKey"];
    objc_setAssociatedObject(self, ActivityIndicatorViewKey, activityIndicatorView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ActivityIndicatorViewKey"];
}

- (UIActivityIndicatorView *)activityIndicatorView {
    return objc_getAssociatedObject(self, &ActivityIndicatorViewKey);
}

- (void)addActivityIndicatorAnimation {
    [self addActivityIndicatorAnimationWithStyle:UIActivityIndicatorViewStyleWhite
                                          center:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
}

- (void)addActivityIndicatorAnimationOnCenter:(CGPoint)center {
    [self addActivityIndicatorAnimationWithStyle:UIActivityIndicatorViewStyleWhite center:center];
}

- (void)addActivityIndicatorAnimationWithStyle:(UIActivityIndicatorViewStyle)style center:(CGPoint)center {
    if (self.activityIndicatorView) {
        return;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    activityIndicatorView.color = [UIColor lightGrayColor];
    activityIndicatorView.center = center;
    self.activityIndicatorView = activityIndicatorView;
    [self addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

- (void)removeActivityIndicatorAnimation {
    [self.activityIndicatorView stopAnimating];
    [self.activityIndicatorView removeFromSuperview];
    self.activityIndicatorView = nil;
}

@end


#pragma mark - 为视图添加渐变环形进度指示器

#import <objc/runtime.h>
#import "GradientCircularProgress.h"

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
    [gradientCircularProgress startAnimation];
}


- (void)removeGradientCircularProgressAnimation {
    [self.gradientCircularProgress stopAnimation];
    [self.gradientCircularProgress removeFromSuperview];
    self.gradientCircularProgress = nil;
}

@end


#pragma mark - 让视图产生半透明毛玻璃效果

@implementation UIView (Blur)

//- (void)blur {
//    self.backgroundColor = [UIColor clearColor];
//    UIToolbar *backgroundToolbar = [[UIToolbar alloc] initWithFrame:self.frame];
//    backgroundToolbar.barStyle = UIBarStyleDefault;
//    backgroundToolbar.autoresizingMask = self.autoresizingMask;
//    backgroundToolbar.clipsToBounds = YES;
//    [self.superview insertSubview:backgroundToolbar atIndex:0];
//}

- (void)blur {
    self.backgroundColor = [UIColor clearColor];
    UIToolbar *backgroundToolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
    backgroundToolbar.barStyle = UIBarStyleDefault;
    backgroundToolbar.clipsToBounds = YES;
    [self insertSubview:backgroundToolbar atIndex:0];
}

@end


#pragma mark - 为视图添加边框

#define kLineBorderWidth 0.5
@implementation UIView (BorderLine)

- (void)setBorderLine {
    [self setBorderLineColor:kBorderLineGrayColor edgeOrientation:CHEdgeOrientationBottom];
    [self setBorderLineColor:kBorderLineGrayColor edgeOrientation:CHEdgeOrientationTop];
    [self setBorderLineColor:kBorderLineGrayColor edgeOrientation:CHEdgeOrientationLeft];
    [self setBorderLineColor:kBorderLineGrayColor edgeOrientation:CHEdgeOrientationRight];
}

- (void)setBorderLineColor:(UIColor *)aColor {
    [self setBorderLineColor:aColor edgeOrientation:CHEdgeOrientationBottom];
    [self setBorderLineColor:aColor edgeOrientation:CHEdgeOrientationTop];
    [self setBorderLineColor:aColor edgeOrientation:CHEdgeOrientationLeft];
    [self setBorderLineColor:aColor edgeOrientation:CHEdgeOrientationRight];
}

- (void)setBorderLineColor:(UIColor *)aColor
           edgeOrientation:(CHEdgeOrientation)orientation {
    CALayer *line = [[CALayer alloc] init];
    line.backgroundColor = aColor.CGColor;
    
    CGRect lineFrame = CGRectZero;
    if (CHEdgeOrientationTop == orientation) {
        // 上边加线
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMinY(self.bounds),
                               CGRectGetWidth(self.bounds),
                               kLineBorderWidth);
    } else if (CHEdgeOrientationLeft == orientation) {
        // 左边加线
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMinY(self.bounds),
                               kLineBorderWidth,
                               CGRectGetHeight(self.bounds));
    } else if (CHEdgeOrientationBottom == orientation) {
        // 底边加线
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMaxY(self.bounds) + kLineBorderWidth,
                               CGRectGetWidth(self.bounds),
                               kLineBorderWidth);
    } else {
        // 右边加线
        lineFrame = CGRectMake(CGRectGetMaxX(self.bounds) - kLineBorderWidth,
                               CGRectGetMinY(self.bounds),
                               kLineBorderWidth,
                               CGRectGetHeight(self.bounds));
    }
    line.frame = lineFrame;
    [self.layer addSublayer:line];
}

@end


#pragma mark - 通过视图查找它所属视图控制器

@implementation UIView (UIViewController)

- (UIViewController *)viewController {
    /// Finds the view's view controller.
    
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    
    // If the view controller isn't found, return nil.
    return nil;
}

@end


#pragma mark - Layer 裁剪等操作

@implementation UIView (Layer)

- (void)setCornerRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)setBorderWidth:(CGFloat)width color:(UIColor *)borderColor {
    self.layer.borderWidth = width;
    self.layer.borderColor = [borderColor CGColor];
}



@end






