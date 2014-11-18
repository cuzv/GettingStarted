//
//  UINavigationBarExtension.m
//  GettingStarted
//
//  Created by Moch on 11/4/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UINavigationBarExtension.h"
#import <objc/runtime.h>
#import "UIViewExtension.h"
#import "NSStringExtension.h"

@implementation UINavigationBarExtension
@end

#pragma mark - 加载进度动画

@interface UINavigationBar ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, assign) BOOL inAnimation;
@property (nonatomic, strong) dispatch_source_t timer;
@end

static const CGFloat kTitleVerticalPositionAdjustment = -5.0f;

static const void *IndicatorAnimationKey = &IndicatorAnimationKey;
static const void *IndicatorInAnimationKey = &IndicatorInAnimationKey;
static const void *IndicatorAnimationTimerKey = &IndicatorAnimationTimerKey;

@implementation UINavigationBar (IndicatorAnimation)

- (void)setTitleLabel:(UILabel *)titleLabel {
	[self willChangeValueForKey:@"IndicatorAnimationKey"];
	objc_setAssociatedObject(self, IndicatorAnimationKey, titleLabel, OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"IndicatorAnimationKey"];
}

- (UILabel *)titleLabel {
	return objc_getAssociatedObject(self, &IndicatorAnimationKey);
}

- (void)setInAnimation:(BOOL)inAnimation {
	[self willChangeValueForKey:@"IndicatorInAnimationKey"];
	objc_setAssociatedObject(self, IndicatorInAnimationKey, @(inAnimation), OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"IndicatorInAnimationKey"];
}

- (BOOL)inAnimation {
	return [objc_getAssociatedObject(self, &IndicatorInAnimationKey) boolValue];
}

- (void)setTimer:(dispatch_source_t)timer {
	[self willChangeValueForKey:@"IndicatorAnimationTimerKey"];
	objc_setAssociatedObject(self, IndicatorAnimationTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self didChangeValueForKey:@"IndicatorAnimationTimerKey"];
}

- (dispatch_source_t)timer {
	return objc_getAssociatedObject(self, &IndicatorAnimationTimerKey);
}

- (void)addIndicatorAnimation {
	if (self.inAnimation) {
		return;
	}
	
	// 调整位置
	[self setTitleVerticalPositionAdjustment:kTitleVerticalPositionAdjustment forBarMetrics:UIBarMetricsDefault];
	// 开启动画
	__weak typeof(self) weakSelf = self;

	[self addSubview:({
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, weakSelf.height - 20, weakSelf.width, 20)];
		CGFloat width = [@"• • •" sizeWithFont:label.font width:weakSelf.width].width;
		label.width = width;
		label.midX = weakSelf.midX;
		label.textColor = weakSelf.titleTextAttributes[NSForegroundColorAttributeName];
		label.textAlignment = NSTextAlignmentLeft;
		
		NSArray *titles = @[@"•    ", @"• •  ", @"• • •", @"     "];
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		weakSelf.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
		if (weakSelf.timer) {
			dispatch_source_set_timer(weakSelf.timer, dispatch_walltime(NULL, 0), 0.5 * NSEC_PER_SEC , 0);
			__block NSUInteger currentIndex = 0;
			dispatch_source_set_event_handler(weakSelf.timer, ^{
				dispatch_async(dispatch_get_main_queue(), ^{
					label.text = titles[currentIndex];
					if (currentIndex++ == titles.count - 1) {
						currentIndex = 0;
					}
				});
			});
			dispatch_source_set_cancel_handler(weakSelf.timer, ^{
				dispatch_async(dispatch_get_main_queue(), ^{
					[weakSelf setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
					weakSelf.inAnimation = NO;
					[weakSelf.titleLabel removeFromSuperview];
					weakSelf.titleLabel = nil;
				});
			});
			dispatch_resume(weakSelf.timer);
		}

		weakSelf.titleLabel = label;
		label;
	})];
	
	self.inAnimation = YES;
}

- (void)removeIndicatorAnimation {
	dispatch_source_cancel(self.timer);
}

- (BOOL)isInAnimation {
	return self.inAnimation;
}

@end