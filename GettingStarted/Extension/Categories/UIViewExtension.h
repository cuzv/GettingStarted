//
//  UIViewExtension.h
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewExtension : NSObject
@end

#pragma mark - 视图框架访问器方法

@interface UIView (Accessor)

/**
 *  设置视图原点
 *
 *  @param point 原点坐标
 */
- (void)setOrigin:(CGPoint)point;

/**
 *  获取视图原点
 *
 *  @return 视图原点坐标
 */
- (CGPoint)origin;

/**
 *  设置视图尺寸大小
 *
 *  @param size 尺寸大小
 */
- (void)setSize:(CGSize)size;

/**
 *  获取视图尺寸大小
 *
 *  @return 尺寸大小
 */
- (CGSize)size;

/**
 *  设置视图横坐标最小值
 *
 *  @param x 横坐标值
 */
- (void)setMinX:(CGFloat)x;

/**
 *  获取视图横坐标最小值
 *
 *  @return 横坐标最小值
 */
- (CGFloat)minX;

/**
 *  设置视图横坐标中间值
 *
 *  @param x 横坐标中间值
 */
- (void)setMidX:(CGFloat)x;

/**
 *  获取视图横坐标中间值
 *
 *  @return 横坐标中间值
 */
- (CGFloat)midX;

/**
 *  设置视图横坐标最大值
 *
 *  @param x 横坐标最大值
 */
- (void)setMaxX:(CGFloat)x;

/**
 *  获取视图横坐标最大值
 *
 *  @return 横坐标最大值
 */
- (CGFloat)maxX;

/**
 *  设置视图纵坐标最小值
 *
 *  @param y 纵坐标最小值
 */
- (void)setMinY:(CGFloat)y;

/**
 *  获取视图纵坐标最小值
 *
 *  @return 纵坐标最小值
 */
- (CGFloat)minY;

/**
 *  设置视图纵坐标中间值
 *
 *  @param y 纵坐标中间值
 */
- (void)setMidY:(CGFloat)y;

/**
 *  获取视图纵坐标中间值
 *
 *  @return 纵坐标中间值
 */
- (CGFloat)midY;

/**
 *  设置视图纵坐标最大值
 *
 *  @param y 纵坐标最大值
 */
- (void)setMaxY:(CGFloat)y;

/**
 *  获取视图纵坐标最大值
 *
 *  @return 纵坐标最大值
 */
- (CGFloat)maxY;

/**
 *  设置视图宽度
 *
 *  @param width 宽度
 */
- (void)setWidth:(CGFloat)width;

/**
 *  获取视图宽度
 *
 *  @return 宽度
 */
- (CGFloat)width;

/**
 *  设置视图高度
 *
 *  @param height 高度
 */
- (void)setHeight:(CGFloat)height;

/**
 *  获取视图高度
 *
 *  @return 高度
 */
- (CGFloat)height;

@end


#pragma mark - 为视图添加动画

@interface UIView (Animation)

@end


#pragma mark - 添加环形动画

@interface UIView (ArcRotationAnimation)

/**
 *  添加环形动画
 *
 *  @param strokeColor 环形颜色
 */
- (void)addArcShapeLayerWithColor:(UIColor *)strokeColor;

/**
 *  添加转圈圈动画
 *
 *  @param duration 动画时长
 */
- (void)addArcRotationAnimaionWithDuration:(NSTimeInterval)duration;

/**
 *  添加转圈圈动画
 *
 *  @param duration 动画时长
 *  @param color    环形颜色
 */
- (void)addArcRotationAnimaionWithDuration:(NSTimeInterval)duration lineColor:(UIColor *)color;

/**
 *  移除转圈圈动画
 */
- (void)removeArcRotationAnimation;


@end


#pragma mark - 为视图添加振动动画效果

typedef NS_ENUM(NSInteger, CHAnimationOrientation) {
    CHAnimationOrientationHorizontal,
    CHAnimationOrientationVertical
};

@interface UIView (ShakeAnimation)

/**
 *  振动效果
 */
- (void)shake;

/**
 *  振动效果
 *
 *  @param orientation 振动方向
 */
- (void)shakeWithOrientation:(CHAnimationOrientation)orientation;

@end


#pragma mark - 加载动画效果(打乒乓球效果)

@interface UIView (PingPang)

/**
 *  加载动画效果(打乒乓球效果)
 */
- (void)addLoadingAnimation;

/**
 *  加载动画效果(打乒乓球效果)
 *
 *  @param color 球星颜色
 */
- (void)addLoadingAnimationWitchColor:(UIColor *)color;

/**
 *  移除动画效果(打乒乓球效果)
 */
- (void)removeLoadingAnimation;

@end


#pragma mark -  吐司框效果

typedef NS_ENUM(NSInteger, CHToastAppearOrientation) {
    CHToastAppearOrientationTop,
    CHToastAppearOrientationBottom
};

@interface UIView (Toast)

/**
 *  弹出吐司框，默认从上方出现(only support portrait orientation)
 *
 *  @param message 土司消息
 */
+ (void)toastWithMessage:(NSString *)message;

/**
 *  弹出吐司框(only support portrait orientation)
 *
 *  @param message     土司消息
 *  @param orientation 出现方向
 */
+ (void)toastWithMessage:(NSString *)message appearOrientation:(CHToastAppearOrientation)orientation;

/**
 *  弹出吐司框
 *
 *  @param message 土司消息
 */
- (void)makeToast:(NSString *)message;

@end


#pragma mark - 为视图添加进度指示器

@interface UIView (UIActivityIndicatorView)

/**
 *  获取进度指示器
 *
 *  @return 进度指示器
 */
- (UIActivityIndicatorView *)activityIndicatorView;

/**
 *  为视图添加进度指示器动画
 */
- (void)addActivityIndicatorAnimation;

/**
 *  为视图添加进度指示器动画
 *
 *  @param center 指示器动画中心位置
 */
- (void)addActivityIndicatorAnimationOnCenter:(CGPoint)center;

/**
 *  移除进度指示器动画
 */
- (void)removeActivityIndicatorAnimation;

@end


#pragma mark - 为视图添加渐变环形进度指示器

@interface UIView (GradientCircularProgress)

/**
 *  为视图添加渐变环形进度指示器动画
 */
- (void)addGradientCircularProgressAnimation;

/**
 *  为视图添加渐变环形进度指示器动画
 *
 *  @param center 指示器动画中心位置
 */
- (void)addGradientCircularProgressAnimationOnCenter:(CGPoint)center;

/**
 *  移除渐变环形进度指示器动画
 */
- (void)removeGradientCircularProgressAnimation;

@end


#pragma mark - 让视图产生半透明毛玻璃效果

@interface UIView (Blur)

/**
 *  让视图产生半透明毛玻璃效果(You should call this message at last when call messages for view)
 */
- (void)blur;

@end

#pragma mark - 为视图添加边框

#define kColorDigit (213 / 255)
#define kBorderLineGrayColor [UIColor colorWithRed:kColorDigit green:kColorDigit blue:kColorDigit alpha:kColorDigit]

typedef NS_ENUM(NSInteger, CHEdgeOrientation) {
    CHEdgeOrientationTop,
    CHEdgeOrientationLeft,
    CHEdgeOrientationBottom,
    CHEdgeOrientationRight
};

@interface UIView (BorderLine)

/**
 *  设置边框
 */
- (void)setBorderLine;

/**
 *  设置边框
 *
 *  @param aColor 边框颜色
 */
- (void)setBorderLineColor:(UIColor *)aColor;

/**
 *  设置边框
 *
 *  @param aColor      边框颜色
 *  @param orientation 哪一条边框
 */
- (void)setBorderLineColor:(UIColor *)aColor edgeOrientation:(CHEdgeOrientation)orientation;

@end


#pragma mark - 通过视图查找它所属视图控制器

@interface UIView (UIViewController)

/**
 *  通过视图查找它所属视图控制器
 *
 *  @return 该所属视图控制器
 */
- (UIViewController *)viewController;

@end


#pragma mark - Layer 裁剪等操作

@interface UIView (Layer)

/**
 *  边角裁剪
 *
 *  @param radius 弧度
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  设置边线
 *
 *  @param width       宽度
 *  @param borderColor 颜色
 */
- (void)setBorderWidth:(CGFloat)width color:(UIColor *)borderColor;

@end


