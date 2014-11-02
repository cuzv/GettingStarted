//
//  UIButtonCategories.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIButtonCategories.h"
#import "UIImageCategories.h"
#import "UIViewCategories.h"

@implementation UIButtonCategories

@end

#pragma mark - 快速生成按钮

@implementation UIButton (Generate)

+ (instancetype)buttonWithFrame:(CGRect)frame
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

+ (instancetype)buttonWithSize:(CGSize)size
                          center:(CGPoint)center
                backgroundImage:(UIImage *)backgroundImage
               highlightedImage:(UIImage *)highlightedImage
                         target:(id)target
                         action:(SEL)selector {
    CGRect frame = CGRectMake(center.x - size.width / 2,
                              center.y - size.height / 2,
                              size.width,
                              size.height);
    return [self buttonWithFrame:frame
                 backgroundImage:backgroundImage
                highlightedImage:highlightedImage
                          target:target
                          action:selector];;
}

+ (instancetype)buttonWithFrame:(CGRect)frame
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
        UIImage *backgroundImage = [UIImage imageWithColor:backgroundColor size:frame.size];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    if (highlightedColor) {
        UIImage *highlightedImage = [UIImage imageWithColor:highlightedColor size:frame.size];
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    }
    
    [button setCornerRadius:5];
    
    return button;
}

+ (instancetype)buttonWithSize:(CGSize)size
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
    return [self buttonWithFrame:frame
                           title:title
                      titleColor:titleColor
                 backgroundColor:backgroundColor
      highlightedBackgroundColor:highlightedColor
                          target:target
                          action:selector];
}


@end


#pragma mark - 点击等待

#import "GapRing.h"
#import "UIImageCategories.h"
#import <objc/runtime.h>
#import "UIColorCategories.h"

@interface UIButton ()
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, strong) NSDictionary *context;
@end

@implementation UIButton (IndicatorAnimation)

static const void *IndicatorAnimationKey = &IndicatorAnimationKey;
static const void *IndicatorAnimationContextKey = &IndicatorAnimationContextKey;

- (void)setAnimating:(BOOL)animating {
    [self willChangeValueForKey:@"IndicatorAnimationKey"];
    objc_setAssociatedObject(self, IndicatorAnimationKey, @(animating), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"IndicatorAnimationKey"];
}

- (BOOL)animating {
    return [objc_getAssociatedObject(self, &IndicatorAnimationKey) boolValue];
}

- (void)setContext:(NSDictionary *)context {
    [self willChangeValueForKey:@"IndicatorAnimationContextKey"];
    objc_setAssociatedObject(self, IndicatorAnimationContextKey, context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"IndicatorAnimationContextKey"];
}

- (NSDictionary *)context {
    return objc_getAssociatedObject(self, &IndicatorAnimationContextKey);
}

#pragma mark -

- (void)addWaitingAnimation {
    if (self.animating) {
        return;
    }
    
    // 保存上下文数据
    self.context = ({
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
    });
    
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
    CGFloat lengthOfSide = self.height * 0.8;
    GapRing *gapRing = [[GapRing alloc] initWithFrame:CGRectMake(0, 0, lengthOfSide, lengthOfSide)];
    gapRing.midX = self.width / 2;
    gapRing.midY = self.height / 2;
    gapRing.lineColor = [UIColor colorWithRGBA:@[@0, @122, @255, @1]];
    [gapRing startAnimation];
    [self addSubview:gapRing];

    self.animating = YES;
}

- (void)removeWaitingAnimation {
    if (!self.animating) {
        return;
    }

    // 移除动画
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[GapRing class]]) {
            GapRing *gapRing = (GapRing *)subView;
            [gapRing stopAnimation];
            [gapRing removeFromSuperview];
            gapRing = nil;
            break;
        }
    }
    
    // 恢复上下文信息
    id context = self.context;
    
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

    self.animating = NO;
}

@end
