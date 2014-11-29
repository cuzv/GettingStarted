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

@interface UIView ()
@property (nonatomic, weak) CAShapeLayer *arcLayer;
@end

@implementation UIView (VArcRotationAnimation)

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
                startAngle:radianFromAngle(-90)
                  endAngle:radianFromAngle(270)
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

@implementation UIView (VShakeAnimation)

- (void)shake {
    [self shakeWithOrientation:VAnimationOrientationHorizontal];
}

- (void)shakeWithOrientation:(VAnimationOrientation)orientation {
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

#pragma mark - 为视图添加进度指示器

#import <objc/runtime.h>

static const void *ActivityIndicatorViewKey = &ActivityIndicatorViewKey;

@interface UIView ()
@property(nonatomic, weak, readwrite) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation UIView (VUIActivityIndicatorView)

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

- (BOOL)isInActivityIndicatorAnimation {
	return self.activityIndicatorView ? YES : NO;
}

@end


#pragma mark - 为视图添加渐变环形进度指示器

#import <objc/runtime.h>
#import "VGradientCircularProgress.h"

static const void *GradientCircularProgressKey = &GradientCircularProgressKey;

@interface UIView ()
@property(nonatomic, weak) VGradientCircularProgress *gradientCircularProgress;
@end

@implementation UIView (VGradientCircularProgress)

- (void)setGradientCircularProgress:(VGradientCircularProgress *)gradientCircularProgress {
    [self willChangeValueForKey:@"GradientCircularProgressKey"];
    objc_setAssociatedObject(self, GradientCircularProgressKey, gradientCircularProgress, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"GradientCircularProgressKey"];
}

- (VGradientCircularProgress *)gradientCircularProgress {
    return objc_getAssociatedObject(self, &GradientCircularProgressKey);
}

- (void)addGradientCircularProgressAnimation {
    [self addGradientCircularProgressAnimationOnCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
}

- (void)addGradientCircularProgressAnimationOnCenter:(CGPoint)center {
    if (self.gradientCircularProgress) {
        return;
    }
    
    VGradientCircularProgress *gradientCircularProgress = [[VGradientCircularProgress alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
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

@implementation UIView (VBlur)

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
@implementation UIView (VBorderLine)

- (void)setBorderLine {
    [self setBorderLineColor:kBorderLineGrayColor edge:VEdgeBottom];
    [self setBorderLineColor:kBorderLineGrayColor edge:VEdgeTop];
    [self setBorderLineColor:kBorderLineGrayColor edge:VEdgeLeft];
    [self setBorderLineColor:kBorderLineGrayColor edge:VEdgeRight];
}

- (void)setBorderLineColor:(UIColor *)aColor {
    [self setBorderLineColor:aColor edge:VEdgeBottom];
    [self setBorderLineColor:aColor edge:VEdgeTop];
    [self setBorderLineColor:aColor edge:VEdgeLeft];
    [self setBorderLineColor:aColor edge:VEdgeRight];
}

- (void)setBorderLineColor:(UIColor *)aColor
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
- (void)addBorderLineConstraintsWithColor:(UIColor *)color edge:(VEdge)edge lineHeightMultiplier:(CGFloat)multiplier {
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

@implementation UIView (VLayer)

- (void)setCornerRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)setBorderWidth:(CGFloat)width color:(UIColor *)borderColor {
    self.layer.borderWidth = width;
    self.layer.borderColor = [borderColor CGColor];
}

@end

#pragma mark - 打印视图层级

@implementation UIView (VLayoutDebugging)
- (void)printAutoLayoutTrace {
#ifdef DEBUG
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
	NSLog(@"%@", [self performSelector:@selector(_autolayoutTrace)]);
#pragma clang diagnostic pop
	
#endif
}

- (void)exerciseAmiguityInLayoutRepeatedly:(BOOL)recursive {
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
			[subview exerciseAmiguityInLayoutRepeatedly:YES];
		}
	}
#endif
}

- (void)printSubviewsTrace {
#ifdef DEBUG
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
	NSLog(@"%@", [self performSelector:@selector(recursiveDescription)]);
#pragma clang diagnostic pop
	
#endif
}



@end


#pragma mark - 添加徽标

#import "VBadgeView.h"

static const void *BadgeKey = &BadgeKey;

@implementation UIView (VBadge)

- (void)setBadgeView:(VBadgeView *)badgeView {
	[self willChangeValueForKey:@"BadgeKey"];
	objc_setAssociatedObject(self, BadgeKey, badgeView, OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"BadgeKey"];
}

- (VBadgeView *)badgeView {
	return objc_getAssociatedObject(self, &BadgeKey);
}

- (void)setBadgeValue:(NSString *)badgeValue {
	if (![self badgeView]) {
		VBadgeView *badeView = [VBadgeView new];
		[self addSubview:badeView];
		[self setBadgeView:badeView];
	}
	
	VBadgeView *badgeView = [self badgeView];
	badgeView.badgeValue = badgeValue;
	
	// Base on Frame
	badgeView.midX = self.width;
	badgeView.midY = 0;
		
	// Base on auto layout
	UIView *superView = self;
	[badgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[superView addConstraints:@[[NSLayoutConstraint constraintWithItem:badgeView
														   attribute:NSLayoutAttributeCenterX
														   relatedBy:NSLayoutRelationEqual
															  toItem:superView
														   attribute:NSLayoutAttributeRight
														  multiplier:1
															constant:0],
								[NSLayoutConstraint constraintWithItem:badgeView
															 attribute:NSLayoutAttributeCenterY
															 relatedBy:NSLayoutRelationEqual
																toItem:superView
															 attribute:NSLayoutAttributeTop
															multiplier:1
															  constant:0]
								]];
}

- (NSString *)badgeValue {
	return [self badgeView].badgeValue;
}

@end


