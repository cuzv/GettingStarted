//
//  UIView+CHXPercentageIndicatorView.m
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

#import "UIView+CHXPercentageIndicatorView.h"
#import "MDRadialProgressView.h"
#import <objc/runtime.h>

static const void *PercentageIndicatorViewKey = &PercentageIndicatorViewKey;

@interface UIView ()
@property (nonatomic, weak) MDRadialProgressView *percentageIndicatorView;
@end

@implementation UIView (CHXPercentageIndicatorView)

- (void)setPercentageIndicatorView:(MDRadialProgressView *)percentageIndicatorView {
    [self willChangeValueForKey:@"PercentageIndicatorViewKey"];
    objc_setAssociatedObject(self, &PercentageIndicatorViewKey, percentageIndicatorView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"PercentageIndicatorViewKey"];
}

- (MDRadialProgressView *)percentageIndicatorView {
    return objc_getAssociatedObject(self, &PercentageIndicatorViewKey);
}

- (void)chx_addPercentageIndicatorView {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [self chx_addPercentageIndicatorViewOnCenter:center withThem:[MDRadialProgressTheme chx_sectorTheme]];
}

- (void)chx_addPercentageIndicatorViewOnCenter:(CGPoint)center withThem:(MDRadialProgressTheme *)theme {
    MDRadialProgressView *percentageIndicatorView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)
                                                                                       andTheme:theme];
    percentageIndicatorView.center = center;
    self.percentageIndicatorView = percentageIndicatorView;
    [self addSubview:percentageIndicatorView];
}

- (void)chx_updatePercentage:(CGFloat)percentage {
    self.percentageIndicatorView.progressCounter = percentage;
    self.percentageIndicatorView.progressTotal = 100;
}

- (void)chx_removePercentageIndicatorView {
    [self.percentageIndicatorView removeFromSuperview];
    self.percentageIndicatorView = nil;
}

@end

@implementation MDRadialProgressTheme (Themes)

+ (instancetype)chx_detailTheme {
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

+ (instancetype)chx_simpleTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.thickness = 15;
    theme.incompletedColor = [UIColor clearColor];
    theme.completedColor = [UIColor orangeColor];
    theme.sliceDividerHidden = YES;
    
    return theme;
}

+ (instancetype)chx_peripheryTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.completedColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    theme.incompletedColor = [UIColor blackColor];
    theme.thickness = 10;
    theme.sliceDividerHidden = YES;
    
    return theme;
}

+ (instancetype)chx_colorfulTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.completedColor = [UIColor colorWithRed:90/255.0 green:200/255.0 blue:251/255.0 alpha:1.0];
    theme.incompletedColor = [UIColor colorWithRed:82/255.0 green:237/255.0 blue:199/255.0 alpha:1.0];
    theme.thickness = 30;
    theme.sliceDividerHidden = NO;
    theme.sliceDividerColor = [UIColor whiteColor];
    theme.sliceDividerThickness = 2;
    
    return theme;
}

+ (instancetype)chx_ringsTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.sliceDividerHidden = NO;
    theme.sliceDividerThickness = 1;
    
    // theme update works both changing the theme or the theme attributes
    theme.labelColor = [UIColor blueColor];
    theme.labelShadowColor = [UIColor clearColor];
    
    return theme;
}

+ (instancetype)chx_sectorTheme {
    MDRadialProgressTheme *theme = [MDRadialProgressTheme new];
    theme.thickness = 70;
    theme.completedColor = [UIColor brownColor];
    theme.sliceDividerThickness = 0;
    
    return theme;
}


@end
