//
//  UINavigationBarCategories.m
//  GettingStarted
//
//  Created by Moch on 11/4/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UINavigationBarCategories.h"
#import <objc/runtime.h>

@implementation UINavigationBarCategories

@end


static const void *HeightKey = &HeightKey;

@implementation UINavigationBar (CustomHeight)

- (void)setHeight:(CGFloat)height {
    [self willChangeValueForKey:@"HeightKey"];
    objc_setAssociatedObject(self, HeightKey, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"HeightKey"];
}

- (CGFloat)height {
    return [objc_getAssociatedObject(self, &HeightKey) doubleValue];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize;
    if (self.height) {
        newSize = CGSizeMake(self.superview.bounds.size.width, self.height);
    } else {
        newSize = [super sizeThatFits:size];
    }
    
    return newSize;
}

@end