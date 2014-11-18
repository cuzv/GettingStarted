//
//  GradientCircularProgress.h
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 渐变环形进度指示器

@interface GradientCircularProgress : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithSevenColorRingFrame:(CGRect )frame;

/**
 *  生成渐变环形进度指示器
 *
 *  @param frame         位置信息
 *  @param trackColor    底色
 *  @param progressColor 进度颜色
 *  @param circluarWidth 环形宽度
 *
 *  @return 渐变环形进度指示器
 */
- (instancetype)initWithFrame:(CGRect)frame
                   trackColor:(UIColor *)trackColor
                progressColor:(UIColor *)progressColor
                circluarWidth:(CGFloat)circluarWidth;

/**
 *  更新进度百分比
 *
 *  @param percent  完成度([0, 100])
 *  @param animated 是否需要动画
 */
- (void)updatePercent:(NSUInteger)percent animated:(BOOL)animated;

/**
 *  开始旋转动画
 */
- (void)startAnimation;

/**
 *  停止旋转动画
 */
- (void)stopAnimation;

@end


