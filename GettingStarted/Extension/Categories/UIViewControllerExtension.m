//
//  UIViewControllerExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//	Copyright (c) 2014 Moch Xiao (htt://github.com/atcuan).
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import "UIViewControllerExtension.h"
#import <objc/runtime.h>
#import "UIViewExtension.h"

@implementation UIViewControllerExtension

@end

#pragma mark -

@implementation UIViewController (VNavigationActivityIndicatorView)

static const void *ContextKey = &ContextKey;
static const void *TitleInAnimationKey = &TitleInAnimationKey;
static const void *RightBarInAnimationKey = &RightBarInAnimationKey;

- (void)pr_setContext:(NSDictionary *)context {
    [self willChangeValueForKey:@"ContextKey"];
    objc_setAssociatedObject(self, ContextKey, context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"ContextKey"];
}

- (NSDictionary *)pr_context {
    return objc_getAssociatedObject(self, &ContextKey);
}

- (void)pr_setTitleInAnimation:(BOOL)titleInAnimation {
    [self willChangeValueForKey:@"TitleInAnimationKey"];
    objc_setAssociatedObject(self, TitleInAnimationKey, @(titleInAnimation), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"TitleInAnimationKey"];
}

- (BOOL)pr_titleInAnimation {
    return [objc_getAssociatedObject(self, &TitleInAnimationKey) boolValue];
}

- (void)pr_setRightBarInAnimation:(BOOL)rightBarInAnimation {
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
    if ([self pr_titleInAnimation]) {
        return;
    }
    
    // save title or title view if have value
	[self pr_setContext:({
		id title = self.navigationItem.title ? : [NSNull null];
		id titleView = self.navigationItem.titleView ? : [NSNull null];
		
		NSMutableDictionary *context = [[NSMutableDictionary alloc] initWithDictionary:[self pr_context]];
		[context setValue:title forKey:@"title"];
		[context setValue:titleView forKey:@"titleView"];
		[context setValue:@"YES" forKey:@"titleAnimation"];
		
		[NSDictionary dictionaryWithDictionary:context];
	})];
	
    // add activity indicator animation
    self.navigationItem.titleView = ({
        [self pr_indicatorAnimationView];
    });
	
	[self pr_setTitleInAnimation:YES];
}

- (void)chx_removeNavigationBarActivityIndicatorAnimation {
    if (![self pr_titleInAnimation]) {
        return;
    }
    
    // remove animation
    [self.navigationItem.titleView chx_removeActivityIndicatorAnimation];
    [self.navigationItem.titleView removeFromSuperview];
    self.navigationItem.titleView = nil;
    
    // recovery context
    id context = [self pr_context];
    
    id titleView = [context valueForKey:@"titleView"];
    if ([titleView isKindOfClass:[UIView class]]) {
        self.navigationItem.titleView = titleView;
    }
    
    id title = [context valueForKey:@"title"];
    if ([title isKindOfClass:[NSString class]]) {
        self.navigationItem.title = title;
    }

	[self pr_setTitleInAnimation:NO];
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
	[self pr_setContext:({
		id rightBarButtonItems = self.navigationItem.rightBarButtonItems ? : [NSNull null];
		NSMutableDictionary *context = [[NSMutableDictionary alloc] initWithDictionary:[self pr_context]];
		[context setValue:rightBarButtonItems forKey:@"rightBarButtonItems"];
		
		[NSDictionary dictionaryWithDictionary:context];
	})];
	
    // add indicator animation
    self.navigationItem.rightBarButtonItem = ({
        UIView *indicatorAnimationView = [self pr_indicatorAnimationView];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:indicatorAnimationView];
        rightItem;
    });
	
	[self pr_setRightBarInAnimation:YES];
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
    id context = [self pr_context];
    
    id rightBarButtonItems = [context valueForKey:@"rightBarButtonItems"];
    if ([rightBarButtonItems isKindOfClass:[NSArray class]] &&
        [rightBarButtonItems count]) {
        self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    }
	
	[self pr_setRightBarInAnimation:NO];
}

- (BOOL)chx_isNavigationActivityIndicatorViewInAnimation {
	return [self chx_rightBarInAnimation] || [self pr_titleInAnimation];
}

#pragma mark -

- (UIView *)pr_indicatorAnimationView {
    UIView *view = [UIView new];
    CGFloat height = [self.navigationController.navigationBar chx_height] / 2;
    view.bounds = CGRectMake(0, 0, height, height);
    [view addActivityIndicatorAnimation];
    
    UIActivityIndicatorView *indicator = [view chx_activityIndicatorView];
    indicator.color = self.navigationController.navigationBar.tintColor;

    return view;
}

#pragma mark - 

- (void)chx_printHierarchy {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
	NSLog(@"%@", [self performSelector:@selector(_printHierarchy)]);
#pragma clang diagnostic pop
}


@end