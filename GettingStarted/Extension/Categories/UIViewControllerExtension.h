//
//  UIViewControllerExtension.h
//  GettingStarted
//
//  Created by Moch on 11/2/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewControllerExtension : NSObject

@end

@interface UIViewController (NavigationActivityIndicatorView)

/**
 *  添加导航栏中间部位进度指示器
 */
- (void)addNavigationBarActivityIndicatorAnimation;

/**
 *  移除导航栏中间部位进度指示器
 */
- (void)removeNavigationBarActivityIndicatorAnimation;


/**
 *  添加导航栏右边部位进度指示器
 */
- (void)addNavigationBarRightItemActivityIndicatorAnimation;

/**
 *  移除导航栏右边部位进度指示器
 */
- (void)removeNavigationBarRightItemActivityIndicatorAnimation;

@end
