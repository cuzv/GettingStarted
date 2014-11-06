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


static const void *CustomHeightKey = &CustomHeightKey;

@implementation UINavigationBar (CustomHeight)



- (void)setCustomHeight:(CGFloat)customHeight {
    [self willChangeValueForKey:@"CustomHeightKey"];
    objc_setAssociatedObject(self, CustomHeightKey, @(customHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"CustomHeightKey"];
}

- (CGFloat)customHeight {
    return [objc_getAssociatedObject(self, &CustomHeightKey) doubleValue];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize;
    if (self.customHeight) {
        newSize = CGSizeMake(self.superview.bounds.size.width, self.customHeight);
    } else {
        newSize = [super sizeThatFits:size];
    }
    
    return newSize;
}

@end