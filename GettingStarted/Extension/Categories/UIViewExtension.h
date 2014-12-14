//
//  UIViewExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-05.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewExtension : NSObject
@end

#pragma mark - 视图框架访问器方法

@interface UIView (CHXAccessor)

/**
 *  设置视图原点
 *
 *  @param point 原点坐标
 */
- (void)chx_setOrigin:(CGPoint)point;

/**
 *  获取视图原点
 *
 *  @return 视图原点坐标
 */
- (CGPoint)chx_origin;

/**
 *  设置视图尺寸大小
 *
 *  @param size 尺寸大小
 */
- (void)chx_setSize:(CGSize)size;

/**
 *  获取视图尺寸大小
 *
 *  @return 尺寸大小
 */
- (CGSize)chx_size;

/**
 *  设置视图横坐标最小值
 *
 *  @param x 横坐标值
 */
- (void)chx_setMinX:(CGFloat)x;

/**
 *  获取视图横坐标最小值
 *
 *  @return 横坐标最小值
 */
- (CGFloat)chx_minX;

/**
 *  设置视图横坐标中间值
 *
 *  @param x 横坐标中间值
 */
- (void)chx_setMidX:(CGFloat)x;

/**
 *  获取视图横坐标中间值
 *
 *  @return 横坐标中间值
 */
- (CGFloat)chx_midX;

/**
 *  设置视图横坐标最大值
 *
 *  @param x 横坐标最大值
 */
- (void)chx_setMaxX:(CGFloat)x;

/**
 *  获取视图横坐标最大值
 *
 *  @return 横坐标最大值
 */
- (CGFloat)chx_maxX;

/**
 *  设置视图纵坐标最小值
 *
 *  @param y 纵坐标最小值
 */
- (void)chx_setMinY:(CGFloat)y;

/**
 *  获取视图纵坐标最小值
 *
 *  @return 纵坐标最小值
 */
- (CGFloat)chx_minY;

/**
 *  设置视图纵坐标中间值
 *
 *  @param y 纵坐标中间值
 */
- (void)chx_setMidY:(CGFloat)y;

/**
 *  获取视图纵坐标中间值
 *
 *  @return 纵坐标中间值
 */
- (CGFloat)chx_midY;

/**
 *  设置视图纵坐标最大值
 *
 *  @param y 纵坐标最大值
 */
- (void)chx_setMaxY:(CGFloat)y;

/**
 *  获取视图纵坐标最大值
 *
 *  @return 纵坐标最大值
 */
- (CGFloat)chx_maxY;

/**
 *  设置视图宽度
 *
 *  @param width 宽度
 */
- (void)chx_setWidth:(CGFloat)width;

/**
 *  获取视图宽度
 *
 *  @return 宽度
 */
- (CGFloat)chx_width;

/**
 *  设置视图高度
 *
 *  @param height 高度
 */
- (void)chx_setHeight:(CGFloat)height;

/**
 *  获取视图高度
 *
 *  @return 高度
 */
- (CGFloat)chx_height;

@end


#pragma mark - 添加环形动画

@interface UIView (CHXArcRotationAnimation)

/**
 *  添加环形动画
 *
 *  @param strokeColor 环形颜色
 */
- (void)chx_addArcShapeLayerWithColor:(UIColor *)strokeColor;

/**
 *  添加转圈圈动画
 *
 *  @param duration 动画时长
 */
- (void)chx_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration;

/**
 *  添加转圈圈动画
 *
 *  @param duration 动画时长
 *  @param color    环形颜色
 */
- (void)chx_addArcRotationAnimaionWithDuration:(NSTimeInterval)duration lineColor:(UIColor *)color;

/**
 *  移除转圈圈动画
 */
- (void)chx_removeArcRotationAnimation;

@end


#pragma mark - 为视图添加振动动画效果

typedef NS_ENUM(NSInteger, CHXAnimationOrientation) {
    CHXAnimationOrientationHorizontal,
    CHXAnimationOrientationVertical
};

@interface UIView (CHXShakeAnimation)

/**
 *  振动效果
 */
- (void)chx_shake;

/**
 *  振动效果
 *
 *  @param orientation 振动方向
 */
- (void)chx_shakeWithOrientation:(CHXAnimationOrientation)orientation;

@end


#pragma mark - 加载动画效果(打乒乓球效果)

@interface UIView (CHXPingPang)

/**
 *  加载动画效果(打乒乓球效果)
 */
- (void)chx_addLoadingAnimation;

/**
 *  加载动画效果(打乒乓球效果)
 *
 *  @param color 球星颜色
 */
- (void)chx_addLoadingAnimationWitchColor:(UIColor *)color;

/**
 *  移除动画效果(打乒乓球效果)
 */
- (void)chx_removeLoadingAnimation;

@end

#pragma mark - 为视图添加进度指示器

@interface UIView (CHXUIActivityIndicatorView)

/**
 *  获取进度指示器
 *
 *  @return 进度指示器
 */
- (UIActivityIndicatorView *)chx_activityIndicatorView;

/**
 *  为视图添加进度指示器动画
 */
- (void)addActivityIndicatorAnimation;

/**
 *  为视图添加进度指示器动画
 *
 *  @param center 指示器动画中心位置
 */
- (void)chx_addActivityIndicatorAnimationOnCenter:(CGPoint)center;

/**
 *  为视图添加进度指示器动画
 *
 *  @param style  进度指示器 类型
 *  @param center 指示器动画中心位置
 */
- (void)chx_addActivityIndicatorAnimationWithStyle:(UIActivityIndicatorViewStyle)style center:(CGPoint)center;

/**
 *  移除进度指示器动画
 */
- (void)chx_removeActivityIndicatorAnimation;

/**
 *  是否正在进行进度动画中
 *
 *  @return 是否正在进行进度动画中
 */
- (BOOL)chx_isInActivityIndicatorAnimation;

@end


#pragma mark - 让视图产生半透明毛玻璃效果

@interface UIView (CHXBlur)

/**
 *  让视图产生半透明毛玻璃效果(You should call this message at last when call messages for view)
 */
- (void)chx_blur;

@end

#pragma mark - 为视图添加边框

#define kColorDigit (213 / 255)
#define kBorderLineGrayColor [UIColor colorWithRed:kColorDigit green:kColorDigit blue:kColorDigit alpha:kColorDigit]

@interface UIView (CHXBorderLine)

/**
 *  设置边框
 */
- (void)chx_setBorderLine;

/**
 *  设置边框
 *
 *  @param aColor 边框颜色
 */
- (void)chx_setBorderLineColor:(UIColor *)aColor;

/**
 *  设置边框
 *
 *  @param aColor      边框颜色
 *  @param orientation 哪一条边框
 */
- (void)chx_setBorderLineColor:(UIColor *)aColor edge:(UIRectEdge)edge;

/**
 *  添加边线约束
 *
 *  @param color      边线颜色
 *  @param edge       边缘方向
 *  @param multiplier 边线高度、宽度乘法器([0, 1])
 */
- (void)chx_setBorderLineConstraintsWithColor:(UIColor *)color edge:(UIRectEdge)edge lineSizeMultiplier:(CGFloat)multiplier;

@end

#pragma mark - 边缘圆角

@interface UIView (CHXCornerRadius)

/**
 *  设置圆角
 *
 *  @param corner 圆角方向
 *  @param radius 圆角大小
 */
- (void)chx_setRoundingCorners:(UIRectCorner)corner radius:(CGFloat)radius;

@end


#pragma mark - 通过视图查找它所属视图控制器

@interface UIView (CHXUIViewController)

/**
 *  通过视图查找它所属视图控制器
 *
 *  @return 该所属视图控制器
 */
- (UIViewController *)chx_viewController;

@end


#pragma mark - Layer 裁剪等操作

@interface UIView (CHXLayer)

/**
 *  边角裁剪
 *
 *  @param radius 弧度
 */
- (void)chx_setCornerRadius:(CGFloat)radius;

/**
 *  设置边线
 *
 *  @param width       宽度
 *  @param borderColor 颜色
 */
- (void)chx_setBorderWidth:(CGFloat)width color:(UIColor *)borderColor;

@end

#pragma mark - 打印视图层级

@interface UIView (CHXLayoutDebugging)

/**
 *  打印自动布局树
 */
- (void)chx_printAutoLayoutTrace;

/**
 *  打印描述具有歧义的约束
 *
 *  @param recursive 是否递归
 */
- (void)chx_exerciseAmiguityInLayoutRepeatedly:(BOOL)recursive;

/**
 *  打印子视图层级关系
 */
- (void)chx_printSubviewsTrace;

@end





