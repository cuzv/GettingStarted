//
//  UIView+PercentageIndicatorView.h
//  GettingStarted
//
//  Created by Moch on 10/1/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressTheme.h"

@interface UIView (VPercentageIndicatorView)

- (void)v_addPercentageIndicatorView;
- (void)v_addPercentageIndicatorViewOnCenter:(CGPoint)center withThem:(MDRadialProgressTheme *)anThemt;
- (void)v_updatePercentage:(CGFloat)percentage;
- (void)v_removePercentageIndicatorView;

@end

@interface MDRadialProgressTheme (Themes)

// standardTheme already have one
//+ (instancetype)standardTheme;
+ (instancetype)v_detailTheme;
+ (instancetype)v_simpleTheme;
+ (instancetype)v_peripheryTheme;
+ (instancetype)v_colorfulTheme;
+ (instancetype)v_ringsTheme;
+ (instancetype)v_sectorTheme;

@end