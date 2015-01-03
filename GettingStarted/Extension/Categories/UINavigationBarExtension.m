//
//  UINavigationBarExtension.m
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

- (void)pr_setTitleLabel:(UILabel *)titleLabel {
	[self willChangeValueForKey:@"IndicatorAnimationKey"];
	objc_setAssociatedObject(self, &IndicatorAnimationKey, titleLabel, OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"IndicatorAnimationKey"];
}

- (UILabel *)pr_titleLabel {
	return objc_getAssociatedObject(self, &IndicatorAnimationKey);
}

- (void)pr_setInAnimation:(BOOL)inAnimation {
	[self willChangeValueForKey:@"IndicatorInAnimationKey"];
	objc_setAssociatedObject(self, &IndicatorInAnimationKey, @(inAnimation), OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"IndicatorInAnimationKey"];
}

- (BOOL)pr_inAnimation {
	return [objc_getAssociatedObject(self, &IndicatorInAnimationKey) boolValue];
}

- (void)pr_setTimer:(dispatch_source_t)timer {
	[self willChangeValueForKey:@"IndicatorAnimationTimerKey"];
	objc_setAssociatedObject(self, &IndicatorAnimationTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self didChangeValueForKey:@"IndicatorAnimationTimerKey"];
}

- (dispatch_source_t)pr_timer {
	return objc_getAssociatedObject(self, &IndicatorAnimationTimerKey);
}

- (void)chx_addIndicatorAnimation {
	if ([self pr_inAnimation]) {
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
		[weakSelf pr_setTimer:dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)];
		if ([weakSelf pr_timer]) {
			dispatch_source_set_timer([weakSelf pr_timer], dispatch_walltime(NULL, 0), 0.5 * NSEC_PER_SEC , 0);
			__block NSUInteger currentIndex = 0;
			dispatch_source_set_event_handler([weakSelf pr_timer], ^{
				dispatch_async(dispatch_get_main_queue(), ^{
					label.text = titles[currentIndex];
					if (currentIndex++ == titles.count - 1) {
						currentIndex = 0;
					}
				});
			});
			dispatch_source_set_cancel_handler([weakSelf pr_timer], ^{
				dispatch_async(dispatch_get_main_queue(), ^{
					[weakSelf setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
					[weakSelf pr_setInAnimation:NO];
					[[weakSelf pr_titleLabel] removeFromSuperview];
					[weakSelf pr_setTitleLabel:nil];
				});
			});
			dispatch_resume([weakSelf pr_timer]);
		}

		[weakSelf pr_setTitleLabel:label];
		label;
	})];
	
	[self pr_setInAnimation:YES];
}

- (void)chx_removeIndicatorAnimation {
	dispatch_source_cancel([self pr_timer]);
}

- (BOOL)chx_isInAnimation {
	return [self pr_inAnimation];
}

@end