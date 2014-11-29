//
//  UIScrollViewExtension.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIScrollViewExtension.h"

@implementation UIScrollViewExtension

@end


#pragma mark - 滚动视图框架访问器方法

@implementation UIScrollView (VAccessor)

- (void)v_setContentInsetTop:(CGFloat)contentInsetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)v_contentInsetTop {
    return self.contentInset.top;
}

- (void)v_setContentInsetBottom:(CGFloat)contentInsetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = contentInsetBottom;
    self.contentInset = inset;
}

- (CGFloat)v_contentInsetBottom {
    return self.contentInset.bottom;
}

- (void)v_setContentInsetLeft:(CGFloat)contentInsetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = contentInsetLeft;
    self.contentInset = inset;
}

- (CGFloat)v_contentInsetLeft {
    return self.contentInset.left;
}

- (void)v_setContentInsetRight:(CGFloat)contentInsetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = contentInsetRight;
    self.contentInset = inset;
}

- (CGFloat)v_contentInsetRight {
    return self.contentInset.right;
}

- (void)v_setContentOffsetX:(CGFloat)contentOffsetX {
    CGPoint offset = self.contentOffset;
    offset.x = contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)v_contentOffsetX {
    return self.contentOffset.x;
}

- (void)v_setContentOffsetY:(CGFloat)contentOffsetY {
    CGPoint offset = self.contentOffset;
    offset.y = contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)v_contentOffsetY {
    return self.contentOffset.y;
}

- (void)v_setContentSizeWidth:(CGFloat)contentSizeWidth {
    CGSize size = self.contentSize;
    size.width = contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)v_contentSizeWidth {
    return self.contentSize.width;
}

- (void)v_setContentSizeHeight:(CGFloat)contentSizeHeight {
    CGSize size = self.contentSize;
    size.height = contentSizeHeight;
    self.contentSize = size;
}

- (CGFloat)v_contentSizeHeight {
    return self.contentSize.height;
}

@end
