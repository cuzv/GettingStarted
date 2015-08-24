//
//  UIViewControllerExtension.h
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

@interface UIViewControllerExtension : NSObject

@end

#pragma mark -

@interface UIViewController (VNavigationActivityIndicatorView)

/**
 *  添加导航栏中间部位进度指示器
 */
- (void)chx_addNavigationBarActivityIndicatorAnimation;

/**
 *  移除导航栏中间部位进度指示器
 */
- (void)chx_removeNavigationBarActivityIndicatorAnimation;


/**
 *  添加导航栏右边部位进度指示器
 */
- (void)chx_addNavigationBarRightItemActivityIndicatorAnimation;

/**
 *  移除导航栏右边部位进度指示器
 */
- (void)chx_removeNavigationBarRightItemActivityIndicatorAnimation;

/**
 *  是否正在动画中
 */
- (BOOL)chx_isNavigationActivityIndicatorViewInAnimation;

#pragma mark -

/**
 *  检查视图控制器
 */
- (void)chx_printHierarchy;

@end
