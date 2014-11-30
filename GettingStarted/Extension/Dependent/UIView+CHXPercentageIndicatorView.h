//
//  UIView+PercentageIndicatorView.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/1/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressTheme.h"

@interface UIView (CHXPercentageIndicatorView)

- (void)chx_addPercentageIndicatorView;
- (void)chx_addPercentageIndicatorViewOnCenter:(CGPoint)center withThem:(MDRadialProgressTheme *)anThemt;
- (void)chx_updatePercentage:(CGFloat)percentage;
- (void)chx_removePercentageIndicatorView;

@end

@interface MDRadialProgressTheme (Themes)

// standardTheme already have one
//+ (instancetype)standardTheme;
+ (instancetype)chx_detailTheme;
+ (instancetype)chx_simpleTheme;
+ (instancetype)chx_peripheryTheme;
+ (instancetype)chx_colorfulTheme;
+ (instancetype)chx_ringsTheme;
+ (instancetype)chx_sectorTheme;

@end