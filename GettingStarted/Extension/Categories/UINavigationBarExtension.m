//
//  UINavigationBarExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/4/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "UINavigationBarExtension.h"
#import <objc/runtime.h>
#import "UIViewExtension.h"
#import "NSStringExtension.h"

@implementation UINavigationBarExtension
@end

#pragma mark - 加载进度动画

static const CGFloat kTitleVerticalPositionAdjustment = -5.0f;

static const void *IndicatorAnimationKey = &IndicatorAnimationKey;
static const void *IndicatorInAnimationKey = &IndicatorInAnimationKey;
static const void *IndicatorAnimationTimerKey = &IndicatorAnimationTimerKey;

@implementation UINavigationBar (VIndicatorAnimation)

- (void)__setTitleLabel:(UILabel *)titleLabel {
	[self willChangeValueForKey:@"IndicatorAnimationKey"];
	objc_setAssociatedObject(self, IndicatorAnimationKey, titleLabel, OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"IndicatorAnimationKey"];
}

- (UILabel *)__titleLabel {
	return objc_getAssociatedObject(self, &IndicatorAnimationKey);
}

- (void)__setInAnimation:(BOOL)inAnimation {
	[self willChangeValueForKey:@"IndicatorInAnimationKey"];
	objc_setAssociatedObject(self, IndicatorInAnimationKey, @(inAnimation), OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"IndicatorInAnimationKey"];
}

- (BOOL)__inAnimation {
	return [objc_getAssociatedObject(self, &IndicatorInAnimationKey) boolValue];
}

- (void)__setTimer:(dispatch_source_t)timer {
	[self willChangeValueForKey:@"IndicatorAnimationTimerKey"];
	objc_setAssociatedObject(self, IndicatorAnimationTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self didChangeValueForKey:@"IndicatorAnimationTimerKey"];
}

- (dispatch_source_t)__timer {
	return objc_getAssociatedObject(self, &IndicatorAnimationTimerKey);
}

- (void)chx_addIndicatorAnimation {
	if ([self __inAnimation]) {
		return;
	}
	
	// 调整位置
	[self setTitleVerticalPositionAdjustment:kTitleVerticalPositionAdjustment forBarMetrics:UIBarMetricsDefault];
	// 开启动画
	__weak typeof(self) weakSelf = self;

	[self addSubview:({
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [weakSelf chx_height] - 20, [weakSelf chx_width], 20)];
		CGFloat width = [@"• • •" chx_sizeWithFont:label.font width:[weakSelf chx_width]].width;
		[label chx_setWidth:width];
		[label chx_setMidX:[weakSelf chx_midX]];
		label.textColor = weakSelf.titleTextAttributes[NSForegroundColorAttributeName];
		label.textAlignment = NSTextAlignmentLeft;
		
		NSArray *titles = @[@"•    ", @"• •  ", @"• • •", @"     "];
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		[weakSelf __setTimer:dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)];
		if ([weakSelf __timer]) {
			dispatch_source_set_timer([weakSelf __timer], dispatch_walltime(NULL, 0), 0.5 * NSEC_PER_SEC , 0);
			__block NSUInteger currentIndex = 0;
			dispatch_source_set_event_handler([weakSelf __timer], ^{
				dispatch_async(dispatch_get_main_queue(), ^{
					label.text = titles[currentIndex];
					if (currentIndex++ == titles.count - 1) {
						currentIndex = 0;
					}
				});
			});
			dispatch_source_set_cancel_handler([weakSelf __timer], ^{
				dispatch_async(dispatch_get_main_queue(), ^{
					[weakSelf setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
					[weakSelf __setInAnimation:NO];
					[[weakSelf __titleLabel] removeFromSuperview];
					[weakSelf __setTitleLabel:nil];
				});
			});
			dispatch_resume([weakSelf __timer]);
		}

		[weakSelf __setTitleLabel:label];
		label;
	})];
	
	[self __setInAnimation:YES];
}

- (void)chx_removeIndicatorAnimation {
	dispatch_source_cancel([self __timer]);
}

- (BOOL)chx_isInAnimation {
	return [self __inAnimation];
}

@end