//
//  UIViewExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//	Copyright (c) 2014 Moch Xiao (htt://github.com/atcuan).
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import "UIViewExtension.h"
#import "CHXGlobalServices.h"

@implementation UIViewExtension
@end

#pragma mark -
#pragma mark - 类别

#pragma mark - 视图框架访问器方法

@implementation UIView (CHXAccessor)

- (void)chx_setOrigin:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y, [self chx_width], [self chx_height]);
}

- (CGPoint)chx_origin {
    return self.frame.origin;
}

- (void)chx_setSize:(CGSize)size {
    self.frame = CGRectMake([self chx_minX], [self chx_minY], size.width, size.height);
}

- (CGSize)chx_size {
    return self.frame.size;
}

- (void)chx_setMinX:(CGFloat)x {
    self.frame = CGRectMake(x, [self chx_minY], [self chx_width], [self chx_height]);
}

- (CGFloat)chx_minX {
    return self.frame.origin.x;
}

- (void)chx_setMidX:(CGFloat)x {
    self.frame = CGRectMake(x - [self chx_width] / 2, [self chx_minY], [self chx_width], [self chx_height]);
}

- (CGFloat)chx_midX {
    return CGRectGetMidX(self.frame);
}

- (void)chx_setMaxX:(CGFloat)x {
    self.frame = CGRectMake(x - [self chx_width], [self chx_minY], [self chx_width], [self chx_height]);
}

- (CGFloat)chx_maxX {
    return [self chx_minX] + [self chx_width];
}

- (void)chx_setMinY:(CGFloat)y {
    self.frame = CGRectMake([self chx_minX], y, [self chx_width], [self chx_height]);
}

- (CGFloat)chx_minY {
    return self.frame.origin.y;
}

- (void)chx_setMidY:(CGFloat)y {
    self.frame = CGRectMake([self chx_minX], y - [self chx_height] / 2, [self chx_width], [self chx_height]);
}

- (CGFloat)chx_midY {
    return CGRectGetMidY(self.frame);
}

- (void)chx_setMaxY:(CGFloat)y {
    self.frame = CGRectMake([self chx_minX], y - [self chx_height], [self chx_width], [self chx_height]);
}

- (CGFloat)chx_maxY {
    return [self chx_minY] + [self chx_height];
}

- (void)chx_setWidth:(CGFloat)width {
    self.frame = CGRectMake([self chx_minX], [self chx_minY], width, [self chx_height]);
}

- (CGFloat)chx_width {
    return CGRectGetWidth(self.bounds);
}

- (void)chx_setHeight:(CGFloat)height {
    self.frame = CGRectMake([self chx_minX], [self chx_minY], [self chx_width], height);
}

- (CGFloat)chx_height {
    return CGRectGetHeight(self.bounds);
}

@end

#pragma mark - 添加环形动画

#import <objc/runtime.h>

@implementation UIView (CHXArcRotationAnimation)

static const void *ArcLayerKey = &ArcLayerKey;
- (void)pr_setArcLayer:(CAShapeLayer *)arcLayer {
    [self willChangeValueForKey:@"ArcLayerKey"];
    objc_setAssociatedObject(self, &ArcLayerKey, arcLayer, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ArcLayerKey"];
}

- (CAShapeLayer *)pr_arcLayer {
    return objc_getAssociatedObject(self, &ArcLayerKey);
}

- (void)chx_addArcShapeLayerWithColor:(UIColor *)strokeColor {
    [self.layer addSublayer:[self pr_arcShapeLayerWithColor:strokeColor]];
}

- (CAShapeLayer *)pr_arcShapeLayerWithColor:(UIColor *)strokeColor {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rect = self.bounds;
    CGFloat half = MIN(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [path addArcWithCenter:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
                    radius:half
                startAngle:chx_radianFromAngle(-90)
                  endAngle:chx_radianFromAngle(270)
                 clockwise:YES];
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.path = path.CGPath;
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = [strokeColor CGColor] ? : [[UIColor lightGrayColor] CGColor];
    arcLayer.lineWidth = 2;
    arcLayer.frame = rect;
    
    return arcLayer;
}

- (void)chx_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration {
    [self chx_addArcRotationAnimaionWithDuration:duration lineColor:[UIColor blueColor]];
}

- (void)chx_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration lineColor:(UIColor *)color {
    if ([self pr_arcLayer]) {
        return;
    }
    // 添加 layer
    CAShapeLayer *arcLayer = [self pr_arcShapeLayerWithColor:color];
    [self pr_setArcLayer:arcLayer];
    [self.layer addSublayer:arcLayer];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithInteger:0];
    animation.toValue = [NSNumber numberWithInteger:1];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    [arcLayer addAnimation:animation forKey:@"animation"];
}

- (void)chx_removeArcRotationAnimation {
    [[self pr_arcLayer] removeAllAnimations];
    [[self pr_arcLayer] removeFromSuperlayer];
    [self pr_setArcLayer:nil];
}

@end


#pragma mark - 为视图添加振动动画效果

@implementation UIView (CHXShakeAnimation)

- (void)chx_shake {
    [self chx_shakeWithOrientation:CHXAnimationOrientationHorizontal];
}

- (void)chx_shakeWithOrientation:(CHXAnimationOrientation)orientation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = orientation == CHXAnimationOrientationHorizontal ? @"position.x" : @"position.y";
    animation.values = @[@0, @10, @-10, @10, @0];
    animation.keyTimes = @[@0, @(1 / 6.0f), @(3 / 6.0f), @(5 / 6.0f), @1];
    animation.duration = 0.4;
    animation.additive = YES;
    [self.layer addAnimation:animation forKey:@"shake"];
}

@end

#pragma mark - 加载动画效果(打乒乓球效果)

#import "CAAnimationExtension.h"

@implementation UIView (CHXPingPang)

- (void)chx_addLoadingAnimation {
    [self chx_addLoadingAnimationWitchColor:[UIColor whiteColor]];
}

#define kCircleTag 300
- (void)chx_addLoadingAnimationWitchColor:(UIColor *)color {
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
    
    CAKeyframeAnimation *positionXAnimation = [CAAnimation chx_loadingPositionXAnimation];
    CAKeyframeAnimation *positionYAnimation = [CAAnimation chx_loadingPositionYAnimation];
    CAKeyframeAnimation *scaleAnimation = [CAAnimation chx_loadingScaleAnimation];
    CAAnimationGroup *loadingAnimationGroup = [CAAnimation chx_loadingAnimationGroup:@[positionXAnimation, scaleAnimation, positionYAnimation]];
    
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

- (void)chx_removeLoadingAnimation {
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

#pragma mark - 为视图添加进度指示器

#import <objc/runtime.h>

static const void *ActivityIndicatorViewKey = &ActivityIndicatorViewKey;

@implementation UIView (CHXUIActivityIndicatorView)

- (void)pr_setActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView {
    [self willChangeValueForKey:@"ActivityIndicatorViewKey"];
    objc_setAssociatedObject(self, ActivityIndicatorViewKey, activityIndicatorView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ActivityIndicatorViewKey"];
}

- (UIActivityIndicatorView *)chx_activityIndicatorView {
    return objc_getAssociatedObject(self, &ActivityIndicatorViewKey);
}

- (void)chx_addActivityIndicatorAnimation {
    [self chx_addActivityIndicatorAnimationWithStyle:UIActivityIndicatorViewStyleWhite
                                              center:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
}

- (void)chx_addActivityIndicatorAnimationOnCenter:(CGPoint)center {
    [self chx_addActivityIndicatorAnimationWithStyle:UIActivityIndicatorViewStyleWhite center:center];
}

- (void)chx_addActivityIndicatorAnimationWithStyle:(UIActivityIndicatorViewStyle)style center:(CGPoint)center {
    if ([self chx_activityIndicatorView]) {
        return;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    activityIndicatorView.color = [UIColor lightGrayColor];
    activityIndicatorView.center = center;
    [self pr_setActivityIndicatorView:activityIndicatorView];
    [self addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

- (void)chx_removeActivityIndicatorAnimation {
    [[self chx_activityIndicatorView] stopAnimating];
    [[self chx_activityIndicatorView] removeFromSuperview];
    [self pr_setActivityIndicatorView:nil];
}

- (BOOL)chx_isInActivityIndicatorAnimation {
    return [self chx_activityIndicatorView] ? YES : NO;
}

@end

#pragma mark - 让视图产生半透明毛玻璃效果

@implementation UIView (CHXBlur)

- (void)chx_blur {
    self.backgroundColor = [UIColor clearColor];
    UIToolbar *backgroundToolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
    backgroundToolbar.barStyle = UIBarStyleDefault;
    backgroundToolbar.clipsToBounds = YES;
    [self insertSubview:backgroundToolbar atIndex:0];
}

@end


#pragma mark - 为视图添加边框

#define kLineBorderWidth 0.5
@implementation UIView (CHXBorderLine)

- (void)chx_setBorderLine {
    [self chx_setBorderLineColor:kBorderLineGrayColor edge:UIRectEdgeAll];
}

- (void)chx_setBorderLineColor:(UIColor *)aColor {
    [self chx_setBorderLineColor:kBorderLineGrayColor edge:UIRectEdgeAll];
}

- (void)chx_setBorderLineColor:(UIColor *)aColor edge:(UIRectEdge)edge {
    CGRect lineFrame = CGRectZero;
    
    if (edge & UIRectEdgeTop) {
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMinY(self.bounds),
                               CGRectGetWidth(self.bounds),
                               kLineBorderWidth);
        [self pr_addBorderLineWithColor:aColor frame:lineFrame];
    }
    
    if (edge & UIRectEdgeBottom) {
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMaxY(self.bounds) + kLineBorderWidth,
                               CGRectGetWidth(self.bounds),
                               kLineBorderWidth);
        [self pr_addBorderLineWithColor:aColor frame:lineFrame];
    }
    
    if (edge & UIRectEdgeLeft) {
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMinY(self.bounds),
                               kLineBorderWidth,
                               CGRectGetHeight(self.bounds));
        [self pr_addBorderLineWithColor:aColor frame:lineFrame];
    }
    
    if (edge & UIRectEdgeRight) {
        lineFrame = CGRectMake(CGRectGetMaxX(self.bounds) - kLineBorderWidth,
                               CGRectGetMinY(self.bounds),
                               kLineBorderWidth,
                               CGRectGetHeight(self.bounds));
        [self pr_addBorderLineWithColor:aColor frame:lineFrame];
    }
}

- (void)pr_addBorderLineWithColor:(UIColor *)aColor frame:(CGRect)aFrame {
    CALayer *line = [[CALayer alloc] init];
    line.backgroundColor = aColor.CGColor;
    line.frame = aFrame;
    [self.layer addSublayer:line];
}

// Auto layout
- (void)chx_setBorderLineConstraintsWithColor:(UIColor *)color edge:(UIRectEdge)edge lineSizeMultiplier:(CGFloat)multiplier {
    if (edge == UIRectEdgeNone) {
        return;
    }
    
    NSLayoutAttribute edgeLayoutAttribute = NSLayoutAttributeNotAnAttribute;
    NSLayoutAttribute centerLayoutAttribute = NSLayoutAttributeNotAnAttribute;
    NSLayoutAttribute sizeLayoutAttribute = NSLayoutAttributeNotAnAttribute;
    NSString *visualFormat = nil;
    
    if (edge & UIRectEdgeLeft) {
        edgeLayoutAttribute = NSLayoutAttributeLeft;
        centerLayoutAttribute = NSLayoutAttributeCenterY;
        sizeLayoutAttribute = NSLayoutAttributeHeight;
        visualFormat = @"[lineView(0.5)]";
        [self pr_addBorderLineConstraintWithEdgeLayoutAttribute:edgeLayoutAttribute centerLayoutAttribute:centerLayoutAttribute sizeLayoutAttribute:sizeLayoutAttribute visualFormat:visualFormat color:color edge:edge lineSizeMultiplier:multiplier];
    }
    
    if (edge & UIRectEdgeRight) {
        edgeLayoutAttribute = NSLayoutAttributeRight;
        centerLayoutAttribute = NSLayoutAttributeCenterY;
        sizeLayoutAttribute = NSLayoutAttributeHeight;
        visualFormat = @"[lineView(0.5)]";
        [self pr_addBorderLineConstraintWithEdgeLayoutAttribute:edgeLayoutAttribute centerLayoutAttribute:centerLayoutAttribute sizeLayoutAttribute:sizeLayoutAttribute visualFormat:visualFormat color:color edge:edge lineSizeMultiplier:multiplier];
    }
    
    if (edge & UIRectEdgeTop) {
        edgeLayoutAttribute = NSLayoutAttributeTop;
        centerLayoutAttribute = NSLayoutAttributeCenterX;
        sizeLayoutAttribute = NSLayoutAttributeWidth;
        visualFormat = @"V:[lineView(0.5)]";
        [self pr_addBorderLineConstraintWithEdgeLayoutAttribute:edgeLayoutAttribute centerLayoutAttribute:centerLayoutAttribute sizeLayoutAttribute:sizeLayoutAttribute visualFormat:visualFormat color:color edge:edge lineSizeMultiplier:multiplier];
    }
    
    if (edge & UIRectEdgeBottom) {
        edgeLayoutAttribute = NSLayoutAttributeBottom;
        centerLayoutAttribute = NSLayoutAttributeCenterX;
        sizeLayoutAttribute = NSLayoutAttributeWidth;
        visualFormat = @"V:[lineView(0.5)]";
        [self pr_addBorderLineConstraintWithEdgeLayoutAttribute:edgeLayoutAttribute centerLayoutAttribute:centerLayoutAttribute sizeLayoutAttribute:sizeLayoutAttribute visualFormat:visualFormat color:color edge:edge lineSizeMultiplier:multiplier];
    }
}

- (void)pr_addBorderLineConstraintWithEdgeLayoutAttribute:(NSLayoutAttribute)edgeLayoutAttribute centerLayoutAttribute:(NSLayoutAttribute)centerLayoutAttribute sizeLayoutAttribute:(NSLayoutAttribute)sizeLayoutAttribute visualFormat:(NSString *)visualFormat color:(UIColor *)color edge:(UIRectEdge)edge lineSizeMultiplier:(CGFloat)multiplier {
    UIView *lineView = [UIView new];
    lineView.backgroundColor = color ? color : kBorderLineGrayColor;
    [lineView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:lineView];
    
    [self addConstraints:@[[NSLayoutConstraint constraintWithItem:lineView
                                                        attribute:edgeLayoutAttribute
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:edgeLayoutAttribute
                                                       multiplier:1
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:lineView
                                                        attribute:centerLayoutAttribute
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:centerLayoutAttribute
                                                       multiplier:1
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:lineView
                                                        attribute:sizeLayoutAttribute
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:sizeLayoutAttribute
                                                       multiplier:multiplier
                                                         constant:0]]
     ];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:nil views:NSDictionaryOfVariableBindings(lineView)]];
    
}

@end


#pragma mark - 边缘圆角

@implementation UIView (CHXCornerRadius)

- (void)chx_setRoundingCorners:(UIRectCorner)corner radius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, 0)];
    CAShapeLayer *cornRadiusLayer = [CAShapeLayer new];
    cornRadiusLayer.path = [path CGPath];
    self.layer.mask = cornRadiusLayer;
}

@end


#pragma mark - 通过视图查找它所属视图控制器

@implementation UIView (CHXUIViewController)

- (UIViewController *)chx_viewController {
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

@implementation UIView (CHXLayer)

- (void)chx_setCornerRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)chx_setBorderWidth:(CGFloat)width color:(UIColor *)borderColor {
    self.layer.borderWidth = width;
    self.layer.borderColor = [borderColor CGColor];
}

@end

#pragma mark - 打印视图层级

@implementation UIView (CHXLayoutDebugging)
- (void)chx_printAutoLayoutTrace {
#ifdef DEBUG
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSLog(@"%@", [self performSelector:@selector(_autolayoutTrace)]);
#pragma clang diagnostic pop
    
#endif
}

- (void)chx_exerciseAmiguityInLayoutRepeatedly:(BOOL)recursive {
#ifdef DEBUG
    if (self.hasAmbiguousLayout) {
        [NSTimer scheduledTimerWithTimeInterval:.5
                                         target:self
                                       selector:@selector(exerciseAmbiguityInLayout)
                                       userInfo:nil
                                        repeats:YES];
    }
    if (recursive) {
        for (UIView *subview in self.subviews) {
            [subview chx_exerciseAmiguityInLayoutRepeatedly:YES];
        }
    }
#endif
}

- (void)chx_printSubviewsTrace {
#ifdef DEBUG
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSLog(@"%@", [self performSelector:@selector(recursiveDescription)]);
#pragma clang diagnostic pop
    
#endif
}



@end


