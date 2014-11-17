//
//  UINavigationBarCategories.h
//  GettingStarted
//
//  Created by Moch on 11/4/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationBarCategories : NSObject

@end


#pragma mark - 自定义导航栏高度

@interface UINavigationBar (CustomHeight)

@property (nonatomic, assign) CGFloat customHeight;

@end


#pragma mark - 加载进度动画

@interface UINavigationBar (IndicatorAnimation)

- (void)addIndicatorAnimation;
- (void)removeIndicatorAnimation;

- (BOOL)isInAnimation;

@end