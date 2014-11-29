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


@implementation UIViewController (VNavigationActivityIndicatorView)

static const void *ContextKey = &ContextKey;
static const void *TitleInAnimationKey = &TitleInAnimationKey;
static const void *RightBarInAnimationKey = &RightBarInAnimationKey;

- (void)v_setContext:(NSDictionary *)context {
    [self willChangeValueForKey:@"ContextKey"];
    objc_setAssociatedObject(self, ContextKey, context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"ContextKey"];
}

- (NSDictionary *)v_context {
    return objc_getAssociatedObject(self, &ContextKey);
}

- (void)v_setTitleInAnimation:(BOOL)titleInAnimation {
    [self willChangeValueForKey:@"TitleInAnimationKey"];
    objc_setAssociatedObject(self, TitleInAnimationKey, @(titleInAnimation), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"TitleInAnimationKey"];
}

- (BOOL)v_titleInAnimation {
    return [objc_getAssociatedObject(self, &TitleInAnimationKey) boolValue];
}

- (void)v_setRightBarInAnimation:(BOOL)rightBarInAnimation {
    [self willChangeValueForKey:@"RightBarInAnimationKey"];
    objc_setAssociatedObject(self, RightBarInAnimationKey, @(rightBarInAnimation), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"RightBarInAnimationKey"];
}

- (BOOL)v_rightBarInAnimation {
    return [objc_getAssociatedObject(self, &RightBarInAnimationKey) boolValue];
}

- (void)v_addNavigationBarActivityIndicatorAnimation {
    if (!self.navigationController) {
        return;
    }
    
    // if add already, return
    if ([self v_titleInAnimation]) {
        return;
    }
    
    // save title or title view if have value
	[self v_setContext:({
		id title = self.navigationItem.title ? : [NSNull null];
		id titleView = self.navigationItem.titleView ? : [NSNull null];
		
		NSMutableDictionary *context = [[NSMutableDictionary alloc] initWithDictionary:[self v_context]];
		[context setValue:title forKey:@"title"];
		[context setValue:titleView forKey:@"titleView"];
		[context setValue:@"YES" forKey:@"titleAnimation"];
		
		[NSDictionary dictionaryWithDictionary:context];
	})];
	
    // add activity indicator animation
    self.navigationItem.titleView = ({
        [self indicatorAnimationView];
    });
	
	[self v_setTitleInAnimation:YES];
}

- (void)v_removeNavigationBarActivityIndicatorAnimation {
    if (![self v_titleInAnimation]) {
        return;
    }
    
    // remove animation
    [self.navigationItem.titleView v_removeActivityIndicatorAnimation];
    [self.navigationItem.titleView removeFromSuperview];
    self.navigationItem.titleView = nil;
    
    // recovery context
    id context = [self v_context];
    
    id titleView = [context valueForKey:@"titleView"];
    if ([titleView isKindOfClass:[UIView class]]) {
        self.navigationItem.titleView = titleView;
    }
    
    id title = [context valueForKey:@"title"];
    if ([title isKindOfClass:[NSString class]]) {
        self.navigationItem.title = title;
    }

	[self v_setTitleInAnimation:NO];
}


- (void)v_addNavigationBarRightItemActivityIndicatorAnimation {
    if (!self.navigationController) {
        return;
    }
    
    // if add already, return
    if ([self v_rightBarInAnimation]) {
        return;
    }
    
    // save right items
	[self v_setContext:({
		id rightBarButtonItems = self.navigationItem.rightBarButtonItems ? : [NSNull null];
		NSMutableDictionary *context = [[NSMutableDictionary alloc] initWithDictionary:[self v_context]];
		[context setValue:rightBarButtonItems forKey:@"rightBarButtonItems"];
		
		[NSDictionary dictionaryWithDictionary:context];
	})];
	
    // add indicator animation
    self.navigationItem.rightBarButtonItem = ({
        UIView *indicatorAnimationView = [self indicatorAnimationView];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:indicatorAnimationView];
        rightItem;
    });
	
	[self v_setRightBarInAnimation:YES];
}

- (void)v_removeNavigationBarRightItemActivityIndicatorAnimation {
    if (![self v_rightBarInAnimation]) {
        return;
    }

    // reomve animation
    [self.navigationItem.rightBarButtonItem.customView v_removeActivityIndicatorAnimation];
    [self.navigationItem.rightBarButtonItem.customView removeFromSuperview];
    self.navigationItem.rightBarButtonItem.customView = nil;
    
    // recovery context
    id context = [self v_context];
    
    id rightBarButtonItems = [context valueForKey:@"rightBarButtonItems"];
    if ([rightBarButtonItems isKindOfClass:[NSArray class]] &&
        [rightBarButtonItems count]) {
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    }
	
	[self v_setRightBarInAnimation:NO];
}

- (BOOL)v_isNavigationActivityIndicatorViewInAnimation {
	return [self v_rightBarInAnimation] || [self v_titleInAnimation];
}

#pragma mark -

- (UIView *)indicatorAnimationView {
    UIView *view = [UIView new];
    CGFloat height = [self.navigationController.navigationBar v_height] / 2;
    view.bounds = CGRectMake(0, 0, height, height);
    [view addActivityIndicatorAnimation];
    
    UIActivityIndicatorView *indicator = [view v_activityIndicatorView];
    indicator.color = self.navigationController.navigationBar.tintColor;

    return view;
}


@end