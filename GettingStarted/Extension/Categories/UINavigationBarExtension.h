//
//  UINavigationBarExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 11/4/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UINavigationBarExtension : NSObject

@end

#pragma mark - 加载进度动画

@interface UINavigationBar (VIndicatorAnimation)

- (void)chx_addIndicatorAnimation;
- (void)chx_removeIndicatorAnimation;

- (BOOL)chx_isInAnimation;

@end