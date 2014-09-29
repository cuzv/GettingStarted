//
//  UIView+Accessor.h
//  Category
//
//  Created by Moch on 14-5-26.
//  Copyright (c) 2014年 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Accessor)

@property (nonatomic, assign) CGFloat width;

- (void)setOrigin:(CGPoint)point;
- (CGPoint)origin;

- (void)setSize:(CGSize)size;
- (CGSize)size;

- (void)setMinX:(CGFloat)x;
- (CGFloat)minX;

- (void)setMidX:(CGFloat)x;
- (CGFloat)midX;

- (void)setMaxX:(CGFloat)x;
- (CGFloat)maxX;

- (void)setMinY:(CGFloat)y;
- (CGFloat)minY;

- (void)setMidY:(CGFloat)y;
- (CGFloat)midY;

- (void)setMaxY:(CGFloat)y;
- (CGFloat)maxY;

- (void)setWidth:(CGFloat)width;
- (CGFloat)width;

- (void)setHeight:(CGFloat)height;
- (CGFloat)height;

@end
