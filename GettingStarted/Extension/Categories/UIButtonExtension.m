//
//  UIButtonExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
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

#import "UIButtonExtension.h"
#import "UIImageExtension.h"
#import "UIViewExtension.h"
#import <objc/runtime.h>

@implementation UIButtonExtension

@end

#pragma mark - 快速生成按钮

@implementation UIButton (CHXGenerate)

+ (instancetype)chx_buttonWithFrame:(CGRect)frame
                    backgroundImage:(UIImage *)backgroundImage
                   highlightedImage:(UIImage *)highlightedImage
                             target:(id)target
                             action:(SEL)selector {
    UIButton *button = [[self alloc] initWithFrame:frame];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    
    return button;
}

+ (instancetype)chx_buttonWithSize:(CGSize)size
                            center:(CGPoint)center
                   backgroundImage:(UIImage *)backgroundImage
                  highlightedImage:(UIImage *)highlightedImage
                            target:(id)target
                            action:(SEL)selector {
    CGRect frame = CGRectMake(center.x - size.width / 2,
                              center.y - size.height / 2,
                              size.width,
                              size.height);
    return [self chx_buttonWithFrame:frame
                     backgroundImage:backgroundImage
                    highlightedImage:highlightedImage
                              target:target
                              action:selector];;
}

+ (instancetype)chx_buttonWithFrame:(CGRect)frame
                              title:(NSString *)title
                         titleColor:(UIColor *)titleColor
                    backgroundColor:(UIColor *)backgroundColor
         highlightedBackgroundColor:(UIColor *)highlightedColor
                             target:(id)target
                             action:(SEL)selector {
    UIButton *button = [[self alloc] initWithFrame:frame];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    
    if (backgroundColor) {
        UIImage *backgroundImage = [UIImage chx_imageWithColor:backgroundColor size:frame.size];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    if (highlightedColor) {
        UIImage *highlightedImage = [UIImage chx_imageWithColor:highlightedColor size:frame.size];
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    [button chx_setCornerRadius:5];
    
    return button;
}

+ (instancetype)chx_buttonWithSize:(CGSize)size
                            center:(CGPoint)center
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                   backgroundColor:(UIColor *)backgroundColor
        highlightedBackgroundColor:(UIColor *)highlightedColor
                            target:(id)target
                            action:(SEL)selector {
    CGRect frame = CGRectMake(center.x - size.width / 2,
                              center.y - size.height / 2,
                              size.width,
                              size.height);
    return [self chx_buttonWithFrame:frame
                               title:title
                          titleColor:titleColor
                     backgroundColor:backgroundColor
          highlightedBackgroundColor:highlightedColor
                              target:target
                              action:selector];
}


@end


#pragma mark - 点击等待

#import "CHXGapRing.h"
#import "UIImageExtension.h"
#import <objc/runtime.h>
#import "UIColorExtension.h"

@implementation UIButton (CHXIndicatorAnimation)

static const void *IndicatorAnimationKey = &IndicatorAnimationKey;
static const void *IndicatorAnimationContextKey = &IndicatorAnimationContextKey;

- (void)pr_setAnimating:(BOOL)animating {
    [self willChangeValueForKey:@"IndicatorAnimationKey"];
    objc_setAssociatedObject(self, &IndicatorAnimationKey, @(animating), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"IndicatorAnimationKey"];
}

- (BOOL)pr_animating {
    return [objc_getAssociatedObject(self, &IndicatorAnimationKey) boolValue];
}

- (void)pr_setContext:(NSDictionary *)context {
    [self willChangeValueForKey:@"IndicatorAnimationContextKey"];
    objc_setAssociatedObject(self, &IndicatorAnimationContextKey, context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"IndicatorAnimationContextKey"];
}

- (NSDictionary *)pr_context {
    return objc_getAssociatedObject(self, &IndicatorAnimationContextKey);
}

#pragma mark -

- (void)chx_addWaitingAnimation {
    if ([self pr_animating]) {
        return;
    }
    
    // 保存上下文数据
    [self pr_setContext:({
        NSMutableDictionary *context = [NSMutableDictionary new];
        
        id normalimage = [self imageForState:UIControlStateNormal] ? : [NSNull null];
        [context setObject:normalimage forKey:@"normalimage"];
        id highlightedImage = [self imageForState:UIControlStateHighlighted] ? : [NSNull null];
        [context setObject:highlightedImage forKey:@"highlightedImage"];
        id selectedImage = [self imageForState:UIControlStateSelected] ? : [NSNull null];
        [context setObject:selectedImage forKey:@"selectedImage"];
        
        id normalBackgroundImage = [self backgroundImageForState:UIControlStateNormal] ? : [NSNull null];
        [context setObject:normalBackgroundImage forKey:@"normalBackgroundImage"];
        id highlightedBackgroundImage = [self backgroundImageForState:UIControlStateHighlighted] ? : [NSNull null];
        [context setObject:highlightedBackgroundImage forKey:@"highlightedBackgroundImage"];
        id selectedBackgroundImage = [self backgroundImageForState:UIControlStateSelected] ? : [NSNull null];
        [context setObject:selectedBackgroundImage forKey:@"selectedBackgroundImage"];
        
        id normalTitle = [self titleForState:UIControlStateNormal] ? : [NSNull null];
        [context setObject:normalTitle forKey:@"normalTitle"];
        id highlightedTitle = [self titleForState:UIControlStateHighlighted]  ? : [NSNull null];
        [context setObject:highlightedTitle forKey:@"highlightedTitle"];
        id selectedTitle = [self titleForState:UIControlStateSelected] ? : [NSNull null];
        [context setObject:selectedTitle forKey:@"selectedTitle"];
        
        id backgroundColor = self.backgroundColor ? : [NSNull null];
        [context setObject:backgroundColor forKey:@"backgroundColor"];
        
        [NSDictionary dictionaryWithDictionary:context];
    })];
    
    // 干掉之前的数据
    [self setImage:nil forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateHighlighted];
    [self setImage:nil forState:UIControlStateSelected];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self setBackgroundImage:nil forState:UIControlStateSelected];
    
    [self setTitle:nil forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateHighlighted];
    [self setTitle:nil forState:UIControlStateSelected];
    
    self.backgroundColor = [UIColor clearColor];
    
    // 添加动画
    CGFloat lengthOfSide = [self chx_height] * 0.8;
    CHXGapRing *gapRing = [[CHXGapRing alloc] initWithFrame:CGRectMake(0, 0, lengthOfSide, lengthOfSide)];
    [gapRing chx_setMidX:[self chx_width] / 2];
    [gapRing chx_setMidY:[self chx_height] / 2];
    gapRing.lineColor = [UIColor chx_colorWithRGBA:@[@0, @122, @255, @1]];
    [gapRing startAnimation];
    [self addSubview:gapRing];
    
    [self pr_setAnimating:YES];
}

- (void)chx_removeWaitingAnimation {
    if (![self pr_animating]) {
        return;
    }
    
    // 移除动画
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[CHXGapRing class]]) {
            CHXGapRing *gapRing = (CHXGapRing *)subView;
            [gapRing stopAnimation];
            [gapRing removeFromSuperview];
            gapRing = nil;
            break;
        }
    }
    
    // 恢复上下文信息
    id context = [self pr_context];
    
    Class imageClass = [UIImage class];
    
    id normalimage = [context objectForKey:@"normalimage"];
    if ([normalimage isKindOfClass:imageClass]) {
        [self setImage:normalimage forState:UIControlStateNormal];
    }
    id highlightedImage = [context objectForKey:@"highlightedImage"];
    if ([highlightedImage isKindOfClass:imageClass]) {
        [self setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    id selectedImage = [context objectForKey:@"selectedImage"];
    if ([selectedImage isKindOfClass:imageClass]) {
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
    
    id normalBackgroundImage = [context objectForKey:@"normalBackgroundImage"];
    if ([normalBackgroundImage isKindOfClass:imageClass]) {
        [self setImage:normalBackgroundImage forState:UIControlStateNormal];
    }
    id highlightedBackgroundImage = [context objectForKey:@"highlightedBackgroundImage"];
    if ([highlightedBackgroundImage isKindOfClass:imageClass]) {
        [self setImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    }
    id selectedBackgroundImage = [context objectForKey:@"selectedBackgroundImage"];
    if ([selectedBackgroundImage isKindOfClass:imageClass]) {
        [self setImage:selectedBackgroundImage forState:UIControlStateSelected];
    }
    
    Class stringClass = [NSString class];
    
    id normalTitle = [context objectForKey:@"normalTitle"];
    if ([normalTitle isKindOfClass:stringClass]) {
        [self setTitle:normalTitle forState:UIControlStateNormal];
    }
    id highlightedTitle = [context objectForKey:@"highlightedTitle"];
    if ([highlightedTitle isKindOfClass:stringClass]) {
        [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
    }
    id selectedTitle = [context objectForKey:@"selectedTitle"];
    if ([selectedTitle isKindOfClass:stringClass]) {
        [self setTitle:selectedTitle forState:UIControlStateSelected];
    }
    
    id backgroundColor = [context objectForKey:@"backgroundColor"];
    if ([backgroundColor isKindOfClass:[UIColor class]]) {
        self.backgroundColor = backgroundColor;
    }
    
    [self pr_setAnimating:NO];
}

- (BOOL)chx_isInAnimation {
    return [self pr_animating];
}

@end


#pragma mark - 图片右对齐

@implementation UIButton (VImageAlignment)

- (void)chx_updateImageAlignmentToRight {
    CGFloat imageWidth = self.currentImage.size.width;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth)];
    
    CGFloat edgeWidth = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, edgeWidth, 0, -edgeWidth)];
}

@end


#pragma mark - 扩大点击范围

static char *RegionalKey;

@implementation UIButton (CHXExpandRegion)

- (void)chx_setExpandRegion:(UIEdgeInsets)inset {
    [self willChangeValueForKey:@"RegionalKey"];
    objc_setAssociatedObject(self, &RegionalKey, [NSValue valueWithUIEdgeInsets:inset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"RegionalKey"];
}

- (UIEdgeInsets)chx_expandRegion {
    return [objc_getAssociatedObject(self, &RegionalKey) UIEdgeInsetsValue];
}

- (CGRect)clickRegional {
    UIEdgeInsets inset = [self chx_expandRegion];
    CGFloat top = inset.top;
    CGFloat bottom = inset.bottom;
    CGFloat left = inset.left;
    CGFloat right = inset.right;
    BOOL regional = top || bottom || left || right;
    if (regional) {
        return CGRectMake(self.bounds.origin.x - left,
                          self.bounds.origin.y - top,
                          self.bounds.size.width + left + right,
                          self.bounds.size.height + top + bottom);
    } else {
        return self.bounds;
    }
}

// Override
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self clickRegional];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}


@end