//
//  UIScrollViewExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 10/29/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "UIScrollViewExtension.h"

@implementation UIScrollViewExtension

@end


#pragma mark - 滚动视图框架访问器方法

@implementation UIScrollView (CHXAccessor)

- (void)chx_setContentInsetTop:(CGFloat)contentInsetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)chx_contentInsetTop {
    return self.contentInset.top;
}

- (void)chx_setContentInsetBottom:(CGFloat)contentInsetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = contentInsetBottom;
    self.contentInset = inset;
}

- (CGFloat)chx_contentInsetBottom {
    return self.contentInset.bottom;
}

- (void)chx_setContentInsetLeft:(CGFloat)contentInsetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = contentInsetLeft;
    self.contentInset = inset;
}

- (CGFloat)chx_contentInsetLeft {
    return self.contentInset.left;
}

- (void)chx_setContentInsetRight:(CGFloat)contentInsetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = contentInsetRight;
    self.contentInset = inset;
}

- (CGFloat)chx_contentInsetRight {
    return self.contentInset.right;
}

- (void)chx_setContentOffsetX:(CGFloat)contentOffsetX {
    CGPoint offset = self.contentOffset;
    offset.x = contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)chx_contentOffsetX {
    return self.contentOffset.x;
}

- (void)chx_setContentOffsetY:(CGFloat)contentOffsetY {
    CGPoint offset = self.contentOffset;
    offset.y = contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)chx_contentOffsetY {
    return self.contentOffset.y;
}

- (void)chx_setContentSizeWidth:(CGFloat)contentSizeWidth {
    CGSize size = self.contentSize;
    size.width = contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)chx_contentSizeWidth {
    return self.contentSize.width;
}

- (void)chx_setContentSizeHeight:(CGFloat)contentSizeHeight {
    CGSize size = self.contentSize;
    size.height = contentSizeHeight;
    self.contentSize = size;
}

- (CGFloat)chx_contentSizeHeight {
    return self.contentSize.height;
}

@end
