//
//  CHXDashLineView.m
//  GettingStarted
//
//  Created by Moch Xiao on 4/22/15.
//  Copyright (c) 2015 Foobar. All rights reserved.
//

#import "CHXDashLineView.h"

@implementation CHXDashLineView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    CGRect frame = self.frame;
    frame.size.height = 1;
    self.backgroundColor = [UIColor clearColor];
    self.frame = frame;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    const CGFloat lengths[] = {10, 10};
    CGContextSetLineDash(context, 0, lengths, (sizeof(lengths) / sizeof(lengths[0])));
    CGContextMoveToPoint(context, 0, CGRectGetHeight(self.bounds) / 2);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 2);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

@end
