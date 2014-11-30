//
//  UIViewControllerExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 11/2/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewControllerExtension : NSObject

@end

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

@end
