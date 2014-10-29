//
//  UIView+PercentageIndicatorView.m
//  GettingStarted
//
//  Created by Moch on 10/1/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIView+PercentageIndicatorView.h"
#import "MDRadialProgressView.h"
#import <objc/runtime.h>

static const void *PercentageIndicatorViewKey = &PercentageIndicatorViewKey;

@interface UIView ()
@property (nonatomic, weak) MDRadialProgressView *percentageIndicatorView;
@end

@implementation UIView (PercentageIndicatorView)

- (void)setPercentageIndicatorView:(MDRadialProgressView *)percentageIndicatorView {
    [self willChangeValueForKey:@"PercentageIndicatorViewKey"];
    objc_setAssociatedObject(self, PercentageIndicatorViewKey, percentageIndicatorView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"PercentageIndicatorViewKey"];
}

- (MDRadialProgressView *)percentageIndicatorView {
    return objc_getAssociatedObject(self, &PercentageIndicatorViewKey);
}

- (void)addPercentageIndicatorView {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [self addPercentageIndicatorViewOnCenter:center withThem:[MDRadialProgressTheme sectorTheme]];
}

- (void)addPercentageIndicatorViewOnCenter:(CGPoint)center withThem:(MDRadialProgressTheme *)theme {
    MDRadialProgressView *percentageIndicatorView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)
                                                                                       andTheme:theme];
    percentageIndicatorView.center = center;
    self.percentageIndicatorView = percentageIndicatorView;
    [self addSubview:percentageIndicatorView];
}

- (void)updatePercentage:(CGFloat)percentage {
    self.percentageIndicatorView.progressCounter = percentage;
    self.percentageIndicatorView.progressTotal = 100;
}

- (void)removePercentageIndicatorView {
    [self.percentageIndicatorView removeFromSuperview];
    self.percentageIndicatorView = nil;
}

@end

@implementation MDRadialProgressTheme (Themes)

+ (instancetype)detailTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.completedColor = [UIColor colorWithRed:90/255.0 green:212/255.0 blue:39/255.0 alpha:1.0];
    theme.incompletedColor = [UIColor colorWithRed:164/255.0 green:231/255.0 blue:134/255.0 alpha:1.0];
    theme.centerColor = [UIColor clearColor];
    theme.centerColor = [UIColor colorWithRed:224/255.0 green:248/255.0 blue:216/255.0 alpha:1.0];
    theme.sliceDividerHidden = YES;
    theme.labelColor = [UIColor blackColor];
    theme.labelShadowColor = [UIColor whiteColor];

    return theme;
}

+ (instancetype)simpleTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.thickness = 15;
    theme.incompletedColor = [UIColor clearColor];
    theme.completedColor = [UIColor orangeColor];
    theme.sliceDividerHidden = YES;

    return theme;
}

+ (instancetype)peripheryTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.completedColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    theme.incompletedColor = [UIColor blackColor];
    theme.thickness = 10;
    theme.sliceDividerHidden = YES;
    
    return theme;
}

+ (instancetype)colorfulTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.completedColor = [UIColor colorWithRed:90/255.0 green:200/255.0 blue:251/255.0 alpha:1.0];
    theme.incompletedColor = [UIColor colorWithRed:82/255.0 green:237/255.0 blue:199/255.0 alpha:1.0];
    theme.thickness = 30;
    theme.sliceDividerHidden = NO;
    theme.sliceDividerColor = [UIColor whiteColor];
    theme.sliceDividerThickness = 2;
    
    return theme;
}

+ (instancetype)ringsTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.sliceDividerHidden = NO;
    theme.sliceDividerThickness = 1;
    
    // theme update works both changing the theme or the theme attributes
    theme.labelColor = [UIColor blueColor];
    theme.labelShadowColor = [UIColor clearColor];

    return theme;
}

+ (instancetype)sectorTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.thickness = 70;
    theme.completedColor = [UIColor brownColor];
    theme.sliceDividerThickness = 0;

    return theme;
}


@end
