//
//  UIViewControllerExtension.m
//  GettingStarted
//
//  Created by Moch on 11/2/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIViewControllerExtension.h"
#import <objc/runtime.h>
#import "UIViewExtension.h"

@implementation UIViewControllerExtension

@end

@interface UIViewController ()

@property (nonatomic, strong) NSDictionary *context;
@property (nonatomic, assign) BOOL titleInAnimation;
@property (nonatomic, assign) BOOL rightBarInAnimation;

@end

@implementation UIViewController (NavigationActivityIndicatorView)

static const void *ContextKey = &ContextKey;
static const void *TitleInAnimationKey = &TitleInAnimationKey;
static const void *RightBarInAnimationKey = &RightBarInAnimationKey;

- (void)setContext:(NSDictionary *)context {
    [self willChangeValueForKey:@"ContextKey"];
    objc_setAssociatedObject(self, ContextKey, context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"ContextKey"];
}

- (NSDictionary *)context {
    return objc_getAssociatedObject(self, &ContextKey);
}

- (void)setTitleInAnimation:(BOOL)titleInAnimation {
    [self willChangeValueForKey:@"TitleInAnimationKey"];
    objc_setAssociatedObject(self, TitleInAnimationKey, @(titleInAnimation), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"TitleInAnimationKey"];
}

- (BOOL)titleInAnimation {
    return [objc_getAssociatedObject(self, &TitleInAnimationKey) boolValue];
}

- (void)setRightBarInAnimation:(BOOL)rightBarInAnimation {
    [self willChangeValueForKey:@"RightBarInAnimationKey"];
    objc_setAssociatedObject(self, RightBarInAnimationKey, @(rightBarInAnimation), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"RightBarInAnimationKey"];
}

- (BOOL)rightBarInAnimation {
    return [objc_getAssociatedObject(self, &RightBarInAnimationKey) boolValue];
}

- (void)addNavigationBarActivityIndicatorAnimation {
    if (!self.navigationController) {
        return;
    }
    
    // if add already, return
    if (self.titleInAnimation) {
        return;
    }
    
    // save title or title view if have value
    self.context = ({
        id title = self.navigationItem.title ? : [NSNull null];
        id titleView = self.navigationItem.titleView ? : [NSNull null];
        
        NSMutableDictionary *context = [[NSMutableDictionary alloc] initWithDictionary:self.context];
        [context setValue:title forKey:@"title"];
        [context setValue:titleView forKey:@"titleView"];
        [context setValue:@"YES" forKey:@"titleAnimation"];
        
        [NSDictionary dictionaryWithDictionary:context];
    });
    
    // add activity indicator animation
    self.navigationItem.titleView = ({
        [self indicatorAnimationView];
    });
    
    self.titleInAnimation = YES;
}

- (void)removeNavigationBarActivityIndicatorAnimation {
    if (!self.titleInAnimation) {
        return;
    }
    
    // remove animation
    [self.navigationItem.titleView removeActivityIndicatorAnimation];
    [self.navigationItem.titleView removeFromSuperview];
    self.navigationItem.titleView = nil;
    
    // recovery context
    id context = self.context;
    
    id titleView = [context valueForKey:@"titleView"];
    if ([titleView isKindOfClass:[UIView class]]) {
        self.navigationItem.titleView = titleView;
    }
    
    id title = [context valueForKey:@"title"];
    if ([title isKindOfClass:[NSString class]]) {
        self.navigationItem.title = title;
    }
    
    self.titleInAnimation = NO;
}


- (void)addNavigationBarRightItemActivityIndicatorAnimation {
    if (!self.navigationController) {
        return;
    }
    
    // if add already, return
    if (self.rightBarInAnimation) {
        return;
    }
    
    // save right items
    self.context = ({
        id rightBarButtonItems = self.navigationItem.rightBarButtonItems ? : [NSNull null];
        NSMutableDictionary *context = [[NSMutableDictionary alloc] initWithDictionary:self.context];
        [context setValue:rightBarButtonItems forKey:@"rightBarButtonItems"];
        
        [NSDictionary dictionaryWithDictionary:context];
    });
    
    // add indicator animation
    self.navigationItem.rightBarButtonItem = ({
        UIView *indicatorAnimationView = [self indicatorAnimationView];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:indicatorAnimationView];
        rightItem;
    });
    
    self.rightBarInAnimation = YES;
}

- (void)removeNavigationBarRightItemActivityIndicatorAnimation {
    if (!self.rightBarInAnimation) {
        return;
    }

    // reomve animation
    [self.navigationItem.rightBarButtonItem.customView removeActivityIndicatorAnimation];
    [self.navigationItem.rightBarButtonItem.customView removeFromSuperview];
    self.navigationItem.rightBarButtonItem.customView = nil;
    
    // recovery context
    id context = self.context;
    
    id rightBarButtonItems = [context valueForKey:@"rightBarButtonItems"];
    if ([rightBarButtonItems isKindOfClass:[NSArray class]] &&
        [rightBarButtonItems count]) {
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    }
    
    self.rightBarInAnimation = NO;
}

- (BOOL)isNavigationActivityIndicatorViewInAnimation {
	return self.rightBarInAnimation || self.titleInAnimation;
}

#pragma mark -

- (UIView *)indicatorAnimationView {
    UIView *view = [UIView new];
    CGFloat height = self.navigationController.navigationBar.height / 2;
    view.bounds = CGRectMake(0, 0, height, height);
    [view addActivityIndicatorAnimation];
    
    UIActivityIndicatorView *indicator = [view activityIndicatorView];
    indicator.color = self.navigationController.navigationBar.tintColor;

    return view;
}


@end