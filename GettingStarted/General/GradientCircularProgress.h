//
//  CircularProgress.h
//  GettingStarted
//
//  Created by Moch on 10/16/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientCircularProgress : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithSevenColorRingFrame:(CGRect )frame;
- (instancetype)initWithFrame:(CGRect)frame
                   trackColor:(UIColor *)trackColor
                progressColor:(UIColor *)progressColor
                circluarWidth:(CGFloat)circluarWidth;

- (void)updatePercent:(NSUInteger)percent animated:(BOOL)animated;

- (void)startRotation;
- (void)stopRotation;

@end
