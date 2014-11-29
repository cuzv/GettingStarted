//
//  UIViewExtension.m
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIViewExtension.h"
#import "VGlobalServices.h"

@implementation UIViewExtension
@end

#pragma mark -
#pragma mark - 类别

#pragma mark - 视图框架访问器方法

@implementation UIView (VAccessor)

- (void)v_setOrigin:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y, [self v_width], [self v_height]);
}

- (CGPoint)v_origin {
    return self.frame.origin;
}

- (void)v_setSize:(CGSize)size {
    self.frame = CGRectMake([self v_minX], [self v_minY], size.width, size.height);
}

- (CGSize)v_size {
    return self.frame.size;
}

- (void)v_setMinX:(CGFloat)x {
    self.frame = CGRectMake(x, [self v_minY], [self v_width], [self v_height]);
}

- (CGFloat)v_minX {
    return self.frame.origin.x;
}

- (void)v_setMidX:(CGFloat)x {
    self.frame = CGRectMake(x - [self v_width] / 2, [self v_minY], [self v_width], [self v_height]);
}

- (CGFloat)v_midX {
    return CGRectGetMidX(self.frame);
}

- (void)v_setMaxX:(CGFloat)x {
    self.frame = CGRectMake(x - [self v_width], [self v_minY], [self v_width], [self v_height]);
}

- (CGFloat)v_maxX {
    return [self v_minX] + [self v_width];
}

- (void)v_setMinY:(CGFloat)y {
    self.frame = CGRectMake([self v_minX], y, [self v_width], [self v_height]);
}

- (CGFloat)v_minY {
    return self.frame.origin.y;
}

- (void)v_setMidY:(CGFloat)y {
    self.frame = CGRectMake([self v_minX], y - [self v_height] / 2, [self v_width], [self v_height]);
}

- (CGFloat)v_midY {
    return CGRectGetMidY(self.frame);
}

- (void)v_setMaxY:(CGFloat)y {
    self.frame = CGRectMake([self v_minX], y - [self v_height], [self v_width], [self v_height]);
}

- (CGFloat)v_maxY {
    return [self v_minY] + [self v_height];
}

- (void)v_setWidth:(CGFloat)width {
    self.frame = CGRectMake([self v_minX], [self v_minY], width, [self v_height]);
}

- (CGFloat)v_width {
    return CGRectGetWidth(self.bounds);
}

- (void)v_setHeight:(CGFloat)height {
    self.frame = CGRectMake([self v_minX], [self v_minY], [self v_width], height);
}

- (CGFloat)v_height {
    return CGRectGetHeight(self.bounds);
}

@end

#pragma mark - 为视图添加动画

@implementation UIView (VAnimation)

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

@implementation UIView (VArcRotationAnimation)

static const void *ArcLayerKey = &ArcLayerKey;
- (void)v_setArcLayer:(CAShapeLayer *)arcLayer {
    [self willChangeValueForKey:@"ArcLayerKey"];
    objc_setAssociatedObject(self, ArcLayerKey, arcLayer, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ArcLayerKey"];
}

- (CAShapeLayer *)v_arcLayer {
    return objc_getAssociatedObject(self, &ArcLayerKey);
}

- (void)v_addArcShapeLayerWithColor:(UIColor *)strokeColor {
    [self.layer addSublayer:[self arcShapeLayerWithColor:strokeColor]];
}

- (CAShapeLayer *)arcShapeLayerWithColor:(UIColor *)strokeColor {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rect = self.bounds;
    CGFloat half = MIN(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [path addArcWithCenter:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
                    radius:half
                startAngle:v_radianFromAngle(-90)
                  endAngle:v_radianFromAngle(270)
                 clockwise:YES];
    CAShapeLayer *arcLayer = [CAShapeLayer layer];
    arcLayer.path = path.CGPath;
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor = [strokeColor CGColor] ? : [[UIColor lightGrayColor] CGColor];
    arcLayer.lineWidth = 2;
    arcLayer.frame = rect;
    
    return arcLayer;
}

- (void)v_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration {
    [self v_addArcRotationAnimaionWithDuration:duration lineColor:[UIColor blueColor]];
}

- (void)v_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration lineColor:(UIColor *)color {
    if ([self v_arcLayer]) {
        return;
    }
    // 添加 layer
    CAShapeLayer *arcLayer = [self arcShapeLayerWithColor:color];
	[self v_setArcLayer:arcLayer];
    [self.layer addSublayer:arcLayer];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithInteger:0];
    animation.toValue = [NSNumber numberWithInteger:1];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    [arcLayer addAnimation:animation forKey:@"animation"];
}

- (void)v_removeArcRotationAnimation {
	[[self v_arcLayer] removeAllAnimations];
    [[self v_arcLayer] removeAllAnimations];
    [[self v_arcLayer] removeFromSuperlayer];
	[self v_setArcLayer:nil];
}

@end


#pragma mark - 为视图添加振动动画效果

@implementation UIView (VShakeAnimation)

- (void)v_shake {
    [self v_shakeWithOrientation:VAnimationOrientationHorizontal];
}

- (void)v_shakeWithOrientation:(VAnimationOrientation)orientation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = orientation == VAnimationOrientationHorizontal ? @"position.x" : @"position.y";
    animation.values = @[@0, @10, @-10, @10, @0];
    animation.keyTimes = @[@0, @(1 / 6.0f), @(3 / 6.0f), @(5 / 6.0f), @1];
    animation.duration = 0.4;
    animation.additive = YES;
    [self.layer addAnimation:animation forKey:@"shake"];
}

@end

#pragma mark - 加载动画效果(打乒乓球效果)

@implementation UIView (VPingPang)

- (void)v_addLoadingAnimation {
    [self v_addLoadingAnimationWitchColor:[UIColor whiteColor]];
}

#define kCircleTag 300
- (void)v_addLoadingAnimationWitchColor:(UIColor *)color {
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

- (void)v_removeLoadingAnimation {
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

@implementation UIView (VUIActivityIndicatorView)

- (void)v_setActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView {
    [self willChangeValueForKey:@"ActivityIndicatorViewKey"];
    objc_setAssociatedObject(self, ActivityIndicatorViewKey, activityIndicatorView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ActivityIndicatorViewKey"];
}

- (UIActivityIndicatorView *)v_activityIndicatorView {
    return objc_getAssociatedObject(self, &ActivityIndicatorViewKey);
}

- (void)addActivityIndicatorAnimation {
    [self addActivityIndicatorAnimationWithStyle:UIActivityIndicatorViewStyleWhite
                                          center:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
}

- (void)v_addActivityIndicatorAnimationOnCenter:(CGPoint)center {
    [self addActivityIndicatorAnimationWithStyle:UIActivityIndicatorViewStyleWhite center:center];
}

- (void)addActivityIndicatorAnimationWithStyle:(UIActivityIndicatorViewStyle)style center:(CGPoint)center {
    if ([self v_activityIndicatorView]) {
        return;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    activityIndicatorView.color = [UIColor lightGrayColor];
    activityIndicatorView.center = center;
	[self v_setActivityIndicatorView:activityIndicatorView];
    [self addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

- (void)v_removeActivityIndicatorAnimation {
    [[self v_activityIndicatorView] stopAnimating];
    [[self v_activityIndicatorView] removeFromSuperview];
	[self v_setActivityIndicatorView:nil];
}

- (BOOL)v_isInActivityIndicatorAnimation {
	return [self v_activityIndicatorView] ? YES : NO;
}

@end

#pragma mark - 让视图产生半透明毛玻璃效果

@implementation UIView (VBlur)

- (void)v_blur {
    self.backgroundColor = [UIColor clearColor];
    UIToolbar *backgroundToolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
    backgroundToolbar.barStyle = UIBarStyleDefault;
    backgroundToolbar.clipsToBounds = YES;
    [self insertSubview:backgroundToolbar atIndex:0];
}

@end


#pragma mark - 为视图添加边框

#define kLineBorderWidth 0.5
@implementation UIView (VBorderLine)

- (void)v_setBorderLine {
    [self v_setBorderLineColor:kBorderLineGrayColor edge:VEdgeBottom];
    [self v_setBorderLineColor:kBorderLineGrayColor edge:VEdgeTop];
    [self v_setBorderLineColor:kBorderLineGrayColor edge:VEdgeLeft];
    [self v_setBorderLineColor:kBorderLineGrayColor edge:VEdgeRight];
}

- (void)v_setBorderLineColor:(UIColor *)aColor {
    [self v_setBorderLineColor:aColor edge:VEdgeBottom];
    [self v_setBorderLineColor:aColor edge:VEdgeTop];
    [self v_setBorderLineColor:aColor edge:VEdgeLeft];
    [self v_setBorderLineColor:aColor edge:VEdgeRight];
}

- (void)v_setBorderLineColor:(UIColor *)aColor
           edge:(VEdge)edge {
    CALayer *line = [[CALayer alloc] init];
    line.backgroundColor = aColor.CGColor;
    
    CGRect lineFrame = CGRectZero;
    if (VEdgeTop == edge) {
        // 上边加线
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMinY(self.bounds),
                               CGRectGetWidth(self.bounds),
                               kLineBorderWidth);
    } else if (VEdgeLeft == edge) {
        // 左边加线
        lineFrame = CGRectMake(CGRectGetMinX(self.bounds),
                               CGRectGetMinY(self.bounds),
                               kLineBorderWidth,
                               CGRectGetHeight(self.bounds));
    } else if (VEdgeBottom == edge) {
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


// Auto layout
- (void)v_addBorderLineConstraintsWithColor:(UIColor *)color edge:(VEdge)edge lineHeightMultiplier:(CGFloat)multiplier {
	UIView *lineView = [UIView new];
	lineView.backgroundColor = color ? color : kBorderLineGrayColor;
	[lineView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self addSubview:lineView];
	
	UIView *superView = self;
	NSLayoutAttribute edgeLayoutAttribute = NSLayoutAttributeNotAnAttribute;
	NSLayoutAttribute centerLayoutAttribute = NSLayoutAttributeNotAnAttribute;
	NSLayoutAttribute sizeLayoutAttribute = NSLayoutAttributeNotAnAttribute;
	NSString *visualFormat = nil;
	switch (edge) {
		case VEdgeLeft:
			edgeLayoutAttribute = NSLayoutAttributeLeft;
			centerLayoutAttribute = NSLayoutAttributeCenterY;
			sizeLayoutAttribute = NSLayoutAttributeHeight;
			visualFormat = @"[lineView(0.5)]";
				break;
		case VEdgeRight:
			edgeLayoutAttribute = NSLayoutAttributeRight;
			centerLayoutAttribute = NSLayoutAttributeCenterY;
			sizeLayoutAttribute = NSLayoutAttributeHeight;
			visualFormat = @"[lineView(0.5)]";
			break;
		case VEdgeTop:
			edgeLayoutAttribute = NSLayoutAttributeTop;
			centerLayoutAttribute = NSLayoutAttributeCenterX;
			sizeLayoutAttribute = NSLayoutAttributeWidth;
			visualFormat = @"V:[lineView(0.5)]";
			break;
		case VEdgeBottom:
			edgeLayoutAttribute = NSLayoutAttributeBottom;
			centerLayoutAttribute = NSLayoutAttributeCenterX;
			sizeLayoutAttribute = NSLayoutAttributeWidth;
			visualFormat = @"V:[lineView(0.5)]";
			break;
	  default:
			break;
	}

	[superView addConstraints:@[
							   [NSLayoutConstraint constraintWithItem:lineView
															attribute:edgeLayoutAttribute
															relatedBy:NSLayoutRelationEqual
															   toItem:superView
															attribute:edgeLayoutAttribute
														   multiplier:1
															 constant:0],
							   [NSLayoutConstraint constraintWithItem:lineView
															attribute:centerLayoutAttribute
															relatedBy:NSLayoutRelationEqual
															   toItem:superView
															attribute:centerLayoutAttribute
														   multiplier:1
															 constant:0],
							   [NSLayoutConstraint constraintWithItem:lineView
															attribute:sizeLayoutAttribute
															relatedBy:NSLayoutRelationEqual
															   toItem:superView
															attribute:sizeLayoutAttribute
														   multiplier:multiplier
															 constant:0]
							   ]
	 ];
	
	[superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:nil views:NSDictionaryOfVariableBindings(lineView)]];
}


@end


#pragma mark - 通过视图查找它所属视图控制器

@implementation UIView (VUIViewController)

- (UIViewController *)v_viewController {
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

@implementation UIView (VLayer)

- (void)v_setCornerRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)v_setBorderWidth:(CGFloat)width color:(UIColor *)borderColor {
    self.layer.borderWidth = width;
    self.layer.borderColor = [borderColor CGColor];
}

@end

#pragma mark - 打印视图层级

@implementation UIView (VLayoutDebugging)
- (void)v_printAutoLayoutTrace {
#ifdef DEBUG
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
	NSLog(@"%@", [self performSelector:@selector(_autolayoutTrace)]);
#pragma clang diagnostic pop
	
#endif
}

- (void)v_exerciseAmiguityInLayoutRepeatedly:(BOOL)recursive {
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
			[subview v_exerciseAmiguityInLayoutRepeatedly:YES];
		}
	}
#endif
}

- (void)v_printSubviewsTrace {
#ifdef DEBUG
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
	NSLog(@"%@", [self performSelector:@selector(recursiveDescription)]);
#pragma clang diagnostic pop
	
#endif
}



@end


