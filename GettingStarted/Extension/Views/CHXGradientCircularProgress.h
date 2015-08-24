//
//  CHXGradientCircularProgress.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/cuzv).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

#pragma mark - 渐变环形进度指示器

@interface CHXGradientCircularProgress : UIView

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

/**
 *  是否正在动画中
 *
 *  @return 是否正在动画中
 */
- (BOOL)isInAnimation;

@end


#pragma mark - 为视图添加渐变环形进度指示器

@interface UIView (CHXGradientCircularProgress)

/**
 *  为视图添加渐变环形进度指示器动画
 */
- (void)chx_addGradientCircularProgressAnimation;

/**
 *  为视图添加渐变环形进度指示器动画
 *
 *  @param center 指示器动画中心位置
 */
- (void)chx_addGradientCircularProgressAnimationOnCenter:(CGPoint)center;

/**
 *  移除渐变环形进度指示器动画
 */
- (void)chx_removeGradientCircularProgressAnimation;

@end




