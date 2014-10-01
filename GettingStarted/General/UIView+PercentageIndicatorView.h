//
//  UIView+PercentageIndicatorView.h
//  GettingStarted
//
//  Created by Moch on 10/1/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressTheme.h"

@interface UIView (PercentageIndicatorView)

- (void)addPercentageIndicatorView;
- (void)addPercentageIndicatorViewOnCenter:(CGPoint)center withThem:(MDRadialProgressTheme *)anThemt;
- (void)updatePercentage:(CGFloat)percentage;
- (void)removePercentageIndicatorView;

@end

@interface MDRadialProgressTheme (Themes)

// standardTheme already have one
//+ (instancetype)standardTheme;
+ (instancetype)detailTheme;
+ (instancetype)simpleTheme;
+ (instancetype)peripheryTheme;
+ (instancetype)colorfulTheme;
+ (instancetype)ringsTheme;
+ (instancetype)sectorTheme;

@end