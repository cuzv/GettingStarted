//
//  UIView+Accessor.m
//  Category
//
//  Created by 肖川 on 14-5-26.
//  Copyright (c) 2014年 Moch. All rights reserved.
//

#import "UIView+Accessor.h"

@implementation UIView (Accessor)

- (void)setOrigin:(CGPoint)point {
    
    self.frame = CGRectMake(point.x, point.y, self.width, self.height);
}

- (CGPoint)origin {
    
    return self.frame.origin;
}

- (void)setSize:(CGSize)size {
    
    self.frame = CGRectMake(self.minX, self.minY, size.width, size.height);
}

- (CGSize)size {
    
    return self.frame.size;
}

- (void)setMinX:(CGFloat)x {
    
    self.frame = CGRectMake(x, self.minY, self.width, self.height);
}

- (CGFloat)minX {
    
    return self.frame.origin.x;
}

- (void)setMidX:(CGFloat)x {

    self.frame = CGRectMake(x - self.width / 2, self.minY, self.width, self.height);
}

- (CGFloat)midX {

    return CGRectGetMidX(self.frame);
}

- (void)setMaxX:(CGFloat)x {

    self.frame = CGRectMake(x - self.width, self.minY, self.width, self.height);
}

- (CGFloat)maxX {

    return self.minX + self.width;
}

- (void)setMinY:(CGFloat)y {
    
    self.frame = CGRectMake(self.minX, y, self.width, self.height);
}

- (CGFloat)minY {

    return self.frame.origin.y;
}

- (void)setMidY:(CGFloat)y {
    
    self.frame = CGRectMake(self.minX, y - self.height / 2, self.width, self.height);
}

- (CGFloat)midY {
    
    return CGRectGetMidY(self.frame);
}

- (void)setMaxY:(CGFloat)y {
    
    self.frame = CGRectMake(self.minX, y - self.height, self.width, self.height);
}

- (CGFloat)maxY {

    return self.minY + self.height;
}

- (void)setWidth:(CGFloat)width {

    self.frame = CGRectMake(self.minX, self.minY, width, self.height);
}

- (CGFloat)width {
    
    return CGRectGetWidth(self.bounds);
}

- (void)setHeight:(CGFloat)height {
    
    self.frame = CGRectMake(self.minX, self.minY, self.width, height);
}

- (CGFloat)height {

    return CGRectGetHeight(self.bounds);
}

@end
