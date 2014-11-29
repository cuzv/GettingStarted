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

@interface UIView (VAccessor)

/**
 *  设置视图原点
 *
 *  @param point 原点坐标
 */
- (void)v_setOrigin:(CGPoint)point;

/**
 *  获取视图原点
 *
 *  @return 视图原点坐标
 */
- (CGPoint)v_origin;

/**
 *  设置视图尺寸大小
 *
 *  @param size 尺寸大小
 */
- (void)v_setSize:(CGSize)size;

/**
 *  获取视图尺寸大小
 *
 *  @return 尺寸大小
 */
- (CGSize)v_size;

/**
 *  设置视图横坐标最小值
 *
 *  @param x 横坐标值
 */
- (void)v_setMinX:(CGFloat)x;

/**
 *  获取视图横坐标最小值
 *
 *  @return 横坐标最小值
 */
- (CGFloat)v_minX;

/**
 *  设置视图横坐标中间值
 *
 *  @param x 横坐标中间值
 */
- (void)v_setMidX:(CGFloat)x;

/**
 *  获取视图横坐标中间值
 *
 *  @return 横坐标中间值
 */
- (CGFloat)v_midX;

/**
 *  设置视图横坐标最大值
 *
 *  @param x 横坐标最大值
 */
- (void)v_setMaxX:(CGFloat)x;

/**
 *  获取视图横坐标最大值
 *
 *  @return 横坐标最大值
 */
- (CGFloat)v_maxX;

/**
 *  设置视图纵坐标最小值
 *
 *  @param y 纵坐标最小值
 */
- (void)v_setMinY:(CGFloat)y;

/**
 *  获取视图纵坐标最小值
 *
 *  @return 纵坐标最小值
 */
- (CGFloat)v_minY;

/**
 *  设置视图纵坐标中间值
 *
 *  @param y 纵坐标中间值
 */
- (void)v_setMidY:(CGFloat)y;

/**
 *  获取视图纵坐标中间值
 *
 *  @return 纵坐标中间值
 */
- (CGFloat)v_midY;

/**
 *  设置视图纵坐标最大值
 *
 *  @param y 纵坐标最大值
 */
- (void)v_setMaxY:(CGFloat)y;

/**
 *  获取视图纵坐标最大值
 *
 *  @return 纵坐标最大值
 */
- (CGFloat)v_maxY;

/**
 *  设置视图宽度
 *
 *  @param width 宽度
 */
- (void)v_setWidth:(CGFloat)width;

/**
 *  获取视图宽度
 *
 *  @return 宽度
 */
- (CGFloat)v_width;

/**
 *  设置视图高度
 *
 *  @param height 高度
 */
- (void)v_setHeight:(CGFloat)height;

/**
 *  获取视图高度
 *
 *  @return 高度
 */
- (CGFloat)v_height;

@end


#pragma mark - 为视图添加动画

@interface UIView (VAnimation)

@end


#pragma mark - 添加环形动画

@interface UIView (VArcRotationAnimation)

/**
 *  添加环形动画
 *
 *  @param strokeColor 环形颜色
 */
- (void)v_addArcShapeLayerWithColor:(UIColor *)strokeColor;

/**
 *  添加转圈圈动画
 *
 *  @param duration 动画时长
 */
- (void)v_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration;

/**
 *  添加转圈圈动画
 *
 *  @param duration 动画时长
 *  @param color    环形颜色
 */
- (void)v_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration lineColor:(UIColor *)color;

/**
 *  移除转圈圈动画
 */
- (void)v_removeArcRotationAnimation;

@end


#pragma mark - 为视图添加振动动画效果

typedef NS_ENUM(NSInteger, VAnimationOrientation) {
    VAnimationOrientationHorizontal,
    VAnimationOrientationVertical
};

@interface UIView (VShakeAnimation)

/**
 *  振动效果
 */
- (void)v_shake;

/**
 *  振动效果
 *
 *  @param orientation 振动方向
 */
- (void)v_shakeWithOrientation:(VAnimationOrientation)orientation;

@end


#pragma mark - 加载动画效果(打乒乓球效果)

@interface UIView (VPingPang)

/**
 *  加载动画效果(打乒乓球效果)
 */
- (void)v_addLoadingAnimation;

/**
 *  加载动画效果(打乒乓球效果)
 *
 *  @param color 球星颜色
 */
- (void)v_addLoadingAnimationWitchColor:(UIColor *)color;

/**
 *  移除动画效果(打乒乓球效果)
 */
- (void)v_removeLoadingAnimation;

@end

#pragma mark - 为视图添加进度指示器

@interface UIView (VUIActivityIndicatorView)

/**
 *  获取进度指示器
 *
 *  @return 进度指示器
 */
- (UIActivityIndicatorView *)v_activityIndicatorView;

/**
 *  为视图添加进度指示器动画
 */
- (void)addActivityIndicatorAnimation;

/**
 *  为视图添加进度指示器动画
 *
 *  @param center 指示器动画中心位置
 */
- (void)v_addActivityIndicatorAnimationOnCenter:(CGPoint)center;

/**
 *  移除进度指示器动画
 */
- (void)v_removeActivityIndicatorAnimation;

/**
 *  是否正在进行进度动画中
 *
 *  @return 是否正在进行进度动画中
 */
- (BOOL)v_isInActivityIndicatorAnimation;

@end


#pragma mark - 让视图产生半透明毛玻璃效果

@interface UIView (VBlur)

/**
 *  让视图产生半透明毛玻璃效果(You should call this message at last when call messages for view)
 */
- (void)v_blur;

@end

#pragma mark - 为视图添加边框

#define kColorDigit (213 / 255)
#define kBorderLineGrayColor [UIColor colorWithRed:kColorDigit green:kColorDigit blue:kColorDigit alpha:kColorDigit]

typedef NS_ENUM(NSInteger, VEdge) {
    VEdgeTop,
	VEdgeLeft,
    VEdgeBottom,
    VEdgeRight
};

@interface UIView (VBorderLine)

/**
 *  设置边框
 */
- (void)v_setBorderLine;

/**
 *  设置边框
 *
 *  @param aColor 边框颜色
 */
- (void)v_setBorderLineColor:(UIColor *)aColor;

/**
 *  设置边框
 *
 *  @param aColor      边框颜色
 *  @param orientation 哪一条边框
 */
- (void)v_setBorderLineColor:(UIColor *)aColor edge:(VEdge)edge;

/**
 *  添加边线约束
 *
 *  @param color      边线颜色
 *  @param edge       边缘方向
 *  @param multiplier 边线高度乘法器([0, 1])
 */
- (void)v_addBorderLineConstraintsWithColor:(UIColor *)color edge:(VEdge)edge lineHeightMultiplier:(CGFloat)multiplier;

@end


#pragma mark - 通过视图查找它所属视图控制器

@interface UIView (VUIViewController)

/**
 *  通过视图查找它所属视图控制器
 *
 *  @return 该所属视图控制器
 */
- (UIViewController *)v_viewController;

@end


#pragma mark - Layer 裁剪等操作

@interface UIView (VLayer)

/**
 *  边角裁剪
 *
 *  @param radius 弧度
 */
- (void)v_setCornerRadius:(CGFloat)radius;

/**
 *  设置边线
 *
 *  @param width       宽度
 *  @param borderColor 颜色
 */
- (void)v_setBorderWidth:(CGFloat)width color:(UIColor *)borderColor;

@end

#pragma mark - 打印视图层级

@interface UIView (VLayoutDebugging)

/**
 *  打印自动布局树
 */
- (void)v_printAutoLayoutTrace;

/**
 *  打印描述具有歧义的约束
 *
 *  @param recursive 是否递归
 */
- (void)v_exerciseAmiguityInLayoutRepeatedly:(BOOL)recursive;

/**
 *  打印子视图层级关系
 */
- (void)v_printSubviewsTrace;

@end





