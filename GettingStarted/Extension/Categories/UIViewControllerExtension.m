//
//  UIViewControllerExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/2/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "UIViewControllerExtension.h"
#import <objc/runtime.h>
#import "UIViewExtension.h"

@implementation UIViewControllerExtension

@end


@implementation UIViewController (VNavigationActivityIndicatorView)

static const void *ContextKey = &ContextKey;
static const void *TitleInAnimationKey = &TitleInAnimationKey;
static const void *RightBarInAnimationKey = &RightBarInAnimationKey;

- (void)__setContext:(NSDictionary *)context {
    [self willChangeValueForKey:@"ContextKey"];
    objc_setAssociatedObject(self, ContextKey, context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"ContextKey"];
}

- (NSDictionary *)__context {
    return objc_getAssociatedObject(self, &ContextKey);
}

- (void)__setTitleInAnimation:(BOOL)titleInAnimation {
    [self willChangeValueForKey:@"TitleInAnimationKey"];
    objc_setAssociatedObject(self, TitleInAnimationKey, @(titleInAnimation), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"TitleInAnimationKey"];
}

- (BOOL)__titleInAnimation {
    return [objc_getAssociatedObject(self, &TitleInAnimationKey) boolValue];
}

- (void)__setRightBarInAnimation:(BOOL)rightBarInAnimation {
    [self willChangeValueForKey:@"RightBarInAnimationKey"];
    objc_setAssociatedObject(self, RightBarInAnimationKey, @(rightBarInAnimation), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"RightBarInAnimationKey"];
}

- (BOOL)chx_rightBarInAnimation {
    return [objc_getAssociatedObject(self, &RightBarInAnimationKey) boolValue];
}

- (void)chx_addNavigationBarActivityIndicatorAnimation {
    if (!self.navigationController) {
        return;
    }
    
    // if add already, return
    if ([self __titleInAnimation]) {
        return;
    }
    
    // save title or title view if have value
	[self __setContext:({
		id title = self.navigationItem.title ? : [NSNull null];
		id titleView = self.navigationItem.titleView ? : [NSNull null];
		
		NSMutableDictionary *context = [[NSMutableDictionary alloc] initWithDictionary:[self __context]];
		[context setValue:title forKey:@"title"];
		[context setValue:titleView forKey:@"titleView"];
		[context setValue:@"YES" forKey:@"titleAnimation"];
		
		[NSDictionary dictionaryWithDictionary:context];
	})];
	
    // add activity indicator animation
    self.navigationItem.titleView = ({
        [self __indicatorAnimationView];
    });
	
	[self __setTitleInAnimation:YES];
}

- (void)chx_removeNavigationBarActivityIndicatorAnimation {
    if (![self __titleInAnimation]) {
        return;
    }
    
    // remove animation
    [self.navigationItem.titleView chx_removeActivityIndicatorAnimation];
    [self.navigationItem.titleView removeFromSuperview];
    self.navigationItem.titleView = nil;
    
    // recovery context
    id context = [self __context];
    
    id titleView = [context valueForKey:@"titleView"];
    if ([titleView isKindOfClass:[UIView class]]) {
        self.navigationItem.titleView = titleView;
    }
    
    id title = [context valueForKey:@"title"];
    if ([title isKindOfClass:[NSString class]]) {
        self.navigationItem.title = title;
    }

	[self __setTitleInAnimation:NO];
}


- (void)chx_addNavigationBarRightItemActivityIndicatorAnimation {
    if (!self.navigationController) {
        return;
    }
    
    // if add already, return
    if ([self chx_rightBarInAnimation]) {
        return;
    }
    
    // save right items
	[self __setContext:({
		id rightBarButtonItems = self.navigationItem.rightBarButtonItems ? : [NSNull null];
		NSMutableDictionary *context = [[NSMutableDictionary alloc] initWithDictionary:[self __context]];
		[context setValue:rightBarButtonItems forKey:@"rightBarButtonItems"];
		
		[NSDictionary dictionaryWithDictionary:context];
	})];
	
    // add indicator animation
    self.navigationItem.rightBarButtonItem = ({
        UIView *indicatorAnimationView = [self __indicatorAnimationView];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:indicatorAnimationView];
        rightItem;
    });
	
	[self __setRightBarInAnimation:YES];
}

- (void)chx_removeNavigationBarRightItemActivityIndicatorAnimation {
    if (![self chx_rightBarInAnimation]) {
        return;
    }

    // reomve animation
    [self.navigationItem.rightBarButtonItem.customView chx_removeActivityIndicatorAnimation];
    [self.navigationItem.rightBarButtonItem.customView removeFromSuperview];
    self.navigationItem.rightBarButtonItem.customView = nil;
    
    // recovery context
    id context = [self __context];
    
    id rightBarButtonItems = [context valueForKey:@"rightBarButtonItems"];
    if ([rightBarButtonItems isKindOfClass:[NSArray class]] &&
        [rightBarButtonItems count]) {
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    }
	
	[self __setRightBarInAnimation:NO];
}

- (BOOL)chx_isNavigationActivityIndicatorViewInAnimation {
	return [self chx_rightBarInAnimation] || [self __titleInAnimation];
}

#pragma mark -

- (UIView *)__indicatorAnimationView {
    UIView *view = [UIView new];
    CGFloat height = [self.navigationController.navigationBar chx_height] / 2;
    view.bounds = CGRectMake(0, 0, height, height);
    [view addActivityIndicatorAnimation];
    
    UIActivityIndicatorView *indicator = [view chx_activityIndicatorView];
    indicator.color = self.navigationController.navigationBar.tintColor;

    return view;
}


@end