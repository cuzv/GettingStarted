//
//  MakeUIViewBetter.m
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "MakeUIViewBetter.h"

@implementation MakeUIViewBetter
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

#import "MakeUILabelBetter.h"
#import "MakeNSStringBetter.h"

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
@property(nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
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


#pragma mark -
#pragma mark - 子类

#pragma mark - 渐变环形进度指示器

// 把角度转换成弧度的方式
#define CHRadian(x) (M_PI * (x) / 180.0f)
#define kGradientCircularProgressAnimationDuration 1.0f
#define kDefaultCircluarWidth 2.0f

@interface GradientCircularProgress ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) NSUInteger percent;
@property (nonatomic, assign) BOOL sevenColorRing;

@end

@implementation GradientCircularProgress

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
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
    // 裁剪为圆形
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2;
    self.layer.masksToBounds = YES;
    
    // 创建 track 路径
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
                                                             radius:(CGRectGetWidth(self.bounds) - circluarWidth) / 2
                                                         startAngle:CHRadian(0)
                                                           endAngle:CHRadian(360)
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
                                                    startAngle:CHRadian(95)
                                                      endAngle:CHRadian(445 + (_sevenColorRing ? 10 : 0))
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
    //    right GradientLayer.locations = @[@0.1, @0.5, @1];
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

- (void)startRotation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.duration = kGradientCircularProgressAnimationDuration;
    basicAnimation.repeatCount = HUGE_VAL;
    basicAnimation.fromValue = 0;
    basicAnimation.toValue = @(2 * M_PI);
    basicAnimation.removedOnCompletion = YES;
    basicAnimation.delegate = self;
    [self.layer addAnimation:basicAnimation forKey:@"rotationZ"];
}

- (void)stopRotation {
    [self.layer removeAllAnimations];
}

// animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!flag) {
        [self startRotation];
    }
}

@end


#pragma mark - 徽标

#import "MakeUIColorBetter.h"
#define kBadgeTextFont [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]

@interface BadgeView ()
@property (nonatomic, strong) UILabel *badgeLabel;
@end

@implementation BadgeView

- (instancetype)initWithOrigin:(CGPoint)origin {
    return [self initWithFrame:CGRectMake(origin.x, origin.y, 0, 0)];
}

- (instancetype)initWithOrigin:(CGPoint)origin unreadNumber:(NSUInteger)unreadNumber {
    if (self = [self initWithOrigin:origin]) {
        [self setUnreadNumber:unreadNumber];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRGBA:@[@255, @65, @73, @1]];
        _badgeLabel = [UILabel new];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.backgroundColor = self.backgroundColor;
        _badgeLabel.font = kBadgeTextFont;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setUnreadNumber:(NSUInteger)unreadNumber {
    _unreadNumber = unreadNumber;
    NSString *unreadStr = _unreadNumber > 99 ? @"99+" : [@(_unreadNumber) stringValue];
    self.width = [unreadStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)
                                         options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:kBadgeTextFont}
                                         context:nil].size.width + 4;
    self.width = self.width < 20 ? 20 : self.width;
    self.height = 20.0f;
    if(unreadNumber > 0) {
        [self setNeedsDisplay];
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
}

- (void)drawRect:(CGRect)rect {
    NSString *unreadStr = _unreadNumber > 99 ? @"99+" : [@(_unreadNumber) stringValue];
    _badgeLabel.text = unreadStr;
    self.layer.cornerRadius = self.width > self.height + 5 ? self.width / 3 : self.width / 2;
    [_badgeLabel drawTextInRect:self.bounds];
}


@end


#pragma mark - 地区选择器

#define kScreenBounds [[UIScreen mainScreen] bounds]

@interface LocationPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;

// datas
@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *cites;
@property (nonatomic, strong) NSArray *areas;

@end

@implementation LocationPickerView

- (instancetype)init {
    return [self initWithLocationPickerType:CHLocationPickerTypeProvinces selectedItem:self.didSelectItem];
}

- (instancetype)initWithLocationPickerType:(CHLocationPickerType)locationPickerType
                              selectedItem:(void (^)(NSString *item))didSelectItem {
    self = [super init];
    if (self) {
        self.locationPickerType = locationPickerType;
        self.didSelectItem = didSelectItem;
        self.backgroundColor = [UIColor clearColor];
        [self initialPickerView];
        [self provinces];
    }
    return self;
}

- (NSArray *)provinces {
    if (!_provinces) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ProvincesAndCitiesAndAreas" ofType:@"plist"];
        _provinces = [NSArray arrayWithContentsOfFile:plistPath];
        _cites = _provinces[0][@"cities"] ? : nil;
        _areas = _cites[0][@"areas"] ? : nil;
    }
    
    return _provinces;
}

- (void)initialPickerView {
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.frame = CGRectMake(0, CGRectGetHeight(kScreenBounds) - 216, 0, 0);
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self addSubview:_pickerView];
    }
}

- (void)showInView:(UIView *)view {
    [view endEditing:YES];
    [view addSubview:self];
    [self appear];
}

- (void)appear {
    self.frame = CGRectOffset(kScreenBounds, 0, CGRectGetHeight(kScreenBounds));
    if ([_delegate respondsToSelector:@selector(locationPickerViewWillAppear:)]) {
        [_delegate locationPickerViewWillAppear:self];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 0, -CGRectGetHeight(kScreenBounds));
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(locationPickerViewDidAppear:)]) {
            [_delegate locationPickerViewDidAppear:self];
        }
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self disAppear];
}

- (void)disAppear {
    if ([_delegate respondsToSelector:@selector(locationPickerViewWillDisAppear:)]) {
        [_delegate locationPickerViewWillDisAppear:self];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([_delegate respondsToSelector:@selector(locationPickerViewDidDisAppear:)]) {
            [_delegate locationPickerViewDidDisAppear:self];
        }
    }];
}


// data source
// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.locationPickerType;
}

// 每一列行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numberOfRowsInComponent = 0;
    switch (component) {
        case 0:
            numberOfRowsInComponent = _provinces.count;
            break;
        case 1:
            numberOfRowsInComponent = _cites.count;
            break;
        case 2:
            numberOfRowsInComponent = _areas.count;
            break;
        default:
            break;
    }
    
    return numberOfRowsInComponent;
}

- (void)callbackWithItem:(NSString *)item {
    if ([_delegate respondsToSelector:@selector(locationPickerView:didSelectItem:)] &&
        [item isKindOfClass:[NSString class]]) {
        [_delegate locationPickerView:self didSelectItem:item];
    }
    if (_didSelectItem) {
        _didSelectItem(item);
    }
}

// delegate will call messages
- (NSString *)callbackItemWithFirstComponetDidSelectedRow:(NSInteger)row {
    NSString *callbackitem = nil;
    switch (self.locationPickerType) {
        case CHLocationPickerTypeProvinces:
            // 只选择省份
            callbackitem = _provinces[row][@"state"];
            break;
        case CHLocationPickerTypeCites:
            // 选择省份、市区
            // 根据第一个分组省份数据更新第二个分组市区数据
            _cites = _provinces[row][@"cities"];
            [_pickerView reloadComponent:1];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            
            // 未拖动第二个分组，返回第二个分组第一元素
            callbackitem = [NSString stringWithFormat:@"%@%@",
                            _provinces[row][@"state"], _cites[0][@"city"]];
            break;
        case CHLocationPickerTypeAreas:
            // 选择省份、市区、县区
            // 根据第一个分组省份数据更新第二个分组市区数据
            _cites = _provinces[row][@"cities"];
            [_pickerView reloadComponent:1];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            
            // 根据第二个分组第一个市区数据更新第三个分组县区数据
            _areas = _cites[0][@"areas"];
            [_pickerView reloadComponent:2];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            callbackitem = [NSString stringWithFormat:@"%@%@%@",
                            _provinces[row][@"state"],
                            _cites[0][@"city"],
                            _areas.count ? _areas[0] : @""];
            break;
        default:
            break;
    }
    return callbackitem;
}

- (NSString *)callbackItemWithSecondComponetDidSelectedRow:(NSInteger)row {
    NSString *callbackitem = nil;
    switch (self.locationPickerType) {
        case CHLocationPickerTypeCites:
            callbackitem = [NSString stringWithFormat:@"%@%@",
                            _provinces[[_pickerView selectedRowInComponent:0]][@"state"],
                            _cites[row][@"city"]];
            break;
        case CHLocationPickerTypeAreas:
            // 根据第二个分组市区数据更新第三个分组县区数据
            _areas = _cites[row][@"areas"];
            [_pickerView reloadComponent:2];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            callbackitem = [NSString stringWithFormat:@"%@%@%@",
                            _provinces[[_pickerView selectedRowInComponent:0]][@"state"],
                            _cites[row][@"city"],
                            _areas.count ? _areas[0] : @""];
            
            break;
        default:
            break;
    }
    return callbackitem;
}

- (NSString *)callbackItemWithThirdComponetDidSelectedRow:(NSInteger)row {
    return [NSString stringWithFormat:@"%@%@%@",
            _provinces[[_pickerView selectedRowInComponent:0]][@"state"],
            _cites[[_pickerView selectedRowInComponent:1]][@"city"],
            _areas.count ? _areas[row] : @""];
}

#pragma mark - delegate

// 每一列的每一行的title
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *titleForComponent = nil;
    switch (component) {
        case 0:
            if ([_provinces[row] isKindOfClass:[NSString class]]) {
                // 如过只有一个分组，直接返回分组数组下的字符串元素
                titleForComponent = _provinces[row];
            } else if ([_provinces[row] isKindOfClass:[NSDictionary class]]) {
                // 如果有两个分组，返回分组元素字典下的某个value值
                titleForComponent = _provinces[row][@"state"];
            }
            break;
        case 1:
            // 如果有2个分组，返回第1个分组字典元素对应的某个value值
            titleForComponent = _cites[row][@"city"];
            break;
        case 2:
            // 如果有3个分组，返回第2个分组字典元素对应的某个value值
            titleForComponent = _areas[row];
        default:
            break;
    }
    return titleForComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *callbackitem = nil;
    switch (component) {
            // 第一个分组拖动完成
        case 0:
            callbackitem = [self callbackItemWithFirstComponetDidSelectedRow:row];
            break;
        case 1:
            // 第二分组拖动完成
            callbackitem = [self callbackItemWithSecondComponetDidSelectedRow:row];
            break;
        case 2: {
            // 第三个分组拖动完成
            callbackitem = [self callbackItemWithThirdComponetDidSelectedRow:row];
        }
            break;
        default:
            break;
    }
    [self callbackWithItem:callbackitem];
}

/*
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
            // 第一个分组拖动完成
        case 0: {
            if (CHLocationPickerTypeProvinces == self.locationPickerType) {
                // 只选择省份
                [self callbackWithItem:_provinces[row][@"state"]];
            } else if (CHLocationPickerTypeCites == self.locationPickerType) {
                // 选择省份、市区
                // 根据第一个分组省份数据更新第二个分组市区数据
                _cites = _provinces[row][@"cities"];
                [pickerView reloadComponent:1];
                [pickerView selectRow:0 inComponent:1 animated:YES];
                
                // 未拖动第二个分组，返回第二个分组第一元素
                NSString *item = [NSString stringWithFormat:@"%@%@", _provinces[row][@"state"], _cites[component][@"city"]];
                [self callbackWithItem:item];
            } else if (CHLocationPickerTypeAreas == self.locationPickerType) {
                // 选择省份、市区、县区
                // 根据第一个分组省份数据更新第二个分组市区数据
                _cites = _provinces[row][@"cities"];
                [pickerView reloadComponent:1];
                [pickerView selectRow:0 inComponent:1 animated:YES];
                
                // 根据第二个分组第一个市区数据更新第三个分组县区数据
                _areas = _cites[0][@"areas"];
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
                NSString *item = [NSString stringWithFormat:@"%@%@%@", _provinces[row][@"state"], _cites[component][@"city"], _areas.count ? _areas[0] : @""];
                [self callbackWithItem:item];
            }
        }
            break;
        case 1: {
            // 第二分组拖动完成
            NSString *item = nil;
            if (CHLocationPickerTypeCites == self.locationPickerType) {
                item = [NSString stringWithFormat:@"%@%@", _provinces[[pickerView selectedRowInComponent:0]][@"state"], _cites[row][@"city"]];
            } else if (CHLocationPickerTypeAreas == self.locationPickerType) {
                // 根据第二个分组市区数据更新第三个分组县区数据
                _areas = _cites[row][@"areas"];
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
                item = [NSString stringWithFormat:@"%@%@%@", _provinces[[pickerView selectedRowInComponent:0]][@"state"], _cites[row][@"city"], _areas.count ? _areas[0] : @""];
            }
            [self callbackWithItem:item];
        }
            break;
        case 2: {
            // 第三个分组拖动完成
            NSString *item = [NSString stringWithFormat:@"%@%@%@", _provinces[[pickerView selectedRowInComponent:0]][@"state"],_cites[[_pickerView selectedRowInComponent:1]][@"city"], _areas.count ? _areas[row] : @""];
            [self callbackWithItem:item];
        }
            break;
        default:
            break;
    }
}

*/

@end


#pragma mark - 录音音轨波形图
#define kSilenceVolume 45.0f
#define kSoundMeterCount 6
#define kMaxRecordDuration HUGE_VAL
#define kWaveUpdateFrequency 0.1f

@interface TrackArcView () {
    int soundMeters[kSoundMeterCount];
}

@property (nonatomic, weak) UIColor *stokeColor;
@property(nonatomic, assign) CGFloat recordTime;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TrackArcView

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame
                   stokeColor:(UIColor *)aColor
                       record:(AVAudioRecorder *)aRecorder {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.stokeColor = aColor;
    self.recorder = aRecorder;
    [self initialize];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    
    [self initialize];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self initialize];
    
    return self;
}

- (void)initialize {
    for(int i = 0; i<kSoundMeterCount; i++) {
        soundMeters[i] = kSilenceVolume;
    }
    self.backgroundColor = [UIColor clearColor];
    if (!self.stokeColor) {
        self.stokeColor = [UIColor lightGrayColor];
    }
}

- (void)updateMeters {
    [self.recorder updateMeters];
    if (self.recordTime > kMaxRecordDuration) {
        return;
    }
    self.recordTime += kWaveUpdateFrequency;
    if ([self.recorder averagePowerForChannel:0] < -kSilenceVolume) {
        [self addSoundMeterItem:kSilenceVolume];
        return;
    }
    [self addSoundMeterItem:[self.recorder averagePowerForChannel:0]];
    NSLog(@"volume:%f",[self.recorder averagePowerForChannel:0]);
}

- (void)addSoundMeterItem:(int)lastValue{
    for(int i=0; i<kSoundMeterCount - 1; i++) {
        soundMeters[i] = soundMeters[i+1];
    }
    soundMeters[kSoundMeterCount - 1] = lastValue;
    
    [self setNeedsDisplay];
}

#pragma mark - Drawing operations

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    int baseLine = CGRectGetHeight(self.bounds) / 2;
    static int multiplier = 1;
    int maxLengthOfWave = 45;
    int maxValueOfMeter = 400;
    int yHeights[6];
    float segement[6] = {0.05, 0.2, 0.35, 0.25, 0.1, 0.05};
    
    [self.stokeColor set];
    CGContextSetLineWidth(context, 2.0);
    
    for (int x = kSoundMeterCount - 1; x >= 0; x--) {
        int multiplier_i = ((int)x % 2) == 0 ? 1 : -1;
        CGFloat y = ((maxValueOfMeter * (maxLengthOfWave - abs(soundMeters[(int)x]))) / maxLengthOfWave);
        yHeights[kSoundMeterCount - 1 - x] = multiplier_i * y * segement[kSoundMeterCount - 1 - x]  * multiplier+ baseLine;
    }
    [self drawLinesWithContext:context BaseLine:baseLine HeightArray:yHeights lineWidth:1.0 alpha:0.8 percent:1.00 segementArray:segement];
    [self drawLinesWithContext:context BaseLine:baseLine HeightArray:yHeights lineWidth:0.5 alpha:0.4 percent:0.66 segementArray:segement];
    [self drawLinesWithContext:context BaseLine:baseLine HeightArray:yHeights lineWidth:0.5 alpha:0.2 percent:0.33 segementArray:segement];
    multiplier = -multiplier;
}

- (void)drawLinesWithContext:(CGContextRef)context
                    BaseLine:(float)baseLine
                 HeightArray:(int*)yHeights
                   lineWidth:(CGFloat)width
                       alpha:(CGFloat)alpha
                     percent:(CGFloat)percent
               segementArray:(float *)segement {
    CGFloat start = 0;
    [self.stokeColor set];
    CGContextSetLineWidth(context, width);
    for (int i = 0; i < 6; i++) {
        if (i % 2 == 0) {
            CGContextMoveToPoint(context, start, baseLine);
            CGFloat width = CGRectGetWidth(self.bounds);
            CGContextAddCurveToPoint(context,
                                     width *segement[i] / 2 + start,
                                     (yHeights[i] - baseLine)*percent + baseLine,
                                     width * segement[i] + width * segement[i + 1] / 2 + start,
                                     (yHeights[i + 1] - baseLine) * percent + baseLine,
                                     width *segement[i] + width *segement[i + 1] + start,
                                     baseLine);
            start += width * segement[i] + width *segement[i + 1];
        }
    }
    CGContextStrokePath(context);
}

#pragma mark - public

- (void)startAnimation {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kWaveUpdateFrequency
                                                  target:self
                                                selector:@selector(updateMeters)
                                                userInfo:nil
                                                 repeats:YES];
    
}

- (void)stopAnimation {
    [self.timer invalidate];
    self.timer = nil;
}

@end
