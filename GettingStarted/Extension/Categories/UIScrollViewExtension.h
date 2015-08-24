//
//  UIScrollViewExtension.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIScrollViewExtension : NSObject

@end

#pragma mark - 滚动视图框架访问器方法

@interface UIScrollView (CHXAccessor)

/**
 *  设置滚动视图的顶部内容缩进
 *
 *  @param contentInsetTop 顶部内容缩进
 */
- (void)chx_setContentInsetTop:(CGFloat)contentInsetTop;

/**
 *  获取滚动视图的顶部内容缩进
 *
 *  @return 顶部内容缩进
 */
- (CGFloat)chx_contentInsetTop;

/**
 *  设置滚动视图的底部内容缩进
 *
 *  @param contentInsetBottom 底部内容缩进
 */
- (void)chx_setContentInsetBottom:(CGFloat)contentInsetBottom;

/**
 *  获取滚动视图的底部内容缩进
 *
 *  @return 底部内容缩进
 */
- (CGFloat)chx_contentInsetBottom;

/**
 *  设置滚动视图左侧内容缩进
 *
 *  @param contentInsetLeft 左侧内容缩进
 */
- (void)chx_setContentInsetLeft:(CGFloat)contentInsetLeft;

/**
 *  获取滚动视图左侧内容缩进
 *
 *  @return 滚动视图左侧内容缩进
 */
- (CGFloat)chx_contentInsetLeft;

/**
 *  设置滚动视图右侧内容缩进
 *
 *  @param contentInsetRight 滚动视图右侧内容缩进
 */
- (void)chx_setContentInsetRight:(CGFloat)contentInsetRight;

/**
 *  获取滚动视图右侧内容缩进
 *
 *  @return 滚动视图右侧内容缩进
 */
- (CGFloat)chx_contentInsetRight;

/**
 *  设置滚动视图内容横向超出位置
 *
 *  @param contentOffsetX 横向超出位置
 */
- (void)chx_setContentOffsetX:(CGFloat)contentOffsetX;

/**
 *  获取滚动视图内容横向超出位置
 *
 *  @return 横向超出位置
 */
- (CGFloat)chx_contentOffsetX;

/**
 *  设置滚动视图内容纵向超出位置
 *
 *  @param contentOffsetY 纵向超出位置
 */
- (void)chx_setContentOffsetY:(CGFloat)contentOffsetY;

/**
 *  获取滚动视图内容纵向超出位置
 *
 *  @return 纵向超出位置
 */
- (CGFloat)chx_contentOffsetY;

/**
 *  设置滚动视图内容宽度
 *
 *  @param contentSizeWidth 内容宽度
 */
- (void)chx_setContentSizeWidth:(CGFloat)contentSizeWidth;

/**
 *  获取滚动视图内容宽度
 *
 *  @return 内容宽度
 */
- (CGFloat)chx_contentSizeWidth;

/**
 *  设置滚动视图内容高度
 *
 *  @param contentSizeHeight 内容高度
 */
- (void)chx_setContentSizeHeight:(CGFloat)contentSizeHeight;

/**
 *  获取滚动视图内容高度
 *
 *  @return 滚动视图内容高度
 */
- (CGFloat)chx_contentSizeHeight;
@end

