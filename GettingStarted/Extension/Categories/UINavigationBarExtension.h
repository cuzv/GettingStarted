//
//  UINavigationBarExtension.h
//  GettingStarted
//
//  Created by Moch on 11/4/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UINavigationBarExtension : NSObject

@end

#pragma mark - 加载进度动画

@interface UINavigationBar (IndicatorAnimation)

- (void)addIndicatorAnimation;
- (void)removeIndicatorAnimation;

- (BOOL)isInAnimation;

@end