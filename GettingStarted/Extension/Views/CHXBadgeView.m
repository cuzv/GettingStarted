//
//  BadgeView.m
//  GettingStarted
//
//  Created by Moch Xiao on 10/29/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXBadgeView.h"
#import "UIColorExtension.h"
#import "UIViewExtension.h"

#define kBadgeTextFont [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]
static CGFloat kBadgeViewHeight = 18.0f;

@interface CHXBadgeView ()
@property (nonatomic, strong) UILabel *badgeLabel;
@end

@implementation CHXBadgeView

- (instancetype)init {
	if (self = [super init]) {
		self.backgroundColor = [UIColor chx_colorWithRGBA:@[@255, @65, @73, @1]];
		_badgeLabel = [UILabel new];
		_badgeLabel.textColor = [UIColor whiteColor];
		_badgeLabel.backgroundColor = self.backgroundColor;
		_badgeLabel.font = kBadgeTextFont;
		_badgeLabel.textAlignment = NSTextAlignmentCenter;
		self.layer.masksToBounds = YES;
	}
	
	return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
	_badgeValue = badgeValue;
	CGFloat calculateWidth = [badgeValue sizeWithAttributes:@{NSFontAttributeName:_badgeLabel.font}].width + kBadgeViewHeight / 2;
	[self chx_setWidth:calculateWidth < kBadgeViewHeight ? kBadgeViewHeight : calculateWidth];
	[self chx_setHeight:kBadgeViewHeight];
	
	BOOL shouldHidden = [badgeValue isEqualToString:@"0"];
	self.hidden = shouldHidden;
	if (!shouldHidden) {
		[self setNeedsDisplay];
		[self invalidateIntrinsicContentSize];
	}
}

- (void)drawRect:(CGRect)rect {
    _badgeLabel.text = _badgeValue;
	self.layer.cornerRadius = kBadgeViewHeight / 2;
    [_badgeLabel drawTextInRect:self.bounds];
}

- (CGSize)intrinsicContentSize {
	return CGSizeMake([self chx_width], [self chx_height]);
}

@end





#pragma mark - 添加徽标

#import "CHXBadgeView.h"
#import <objc/runtime.h>

static const void *BadgeKey = &BadgeKey;

@implementation UIView (CHXBadge)

- (void)__setBadgeView:(CHXBadgeView *)badgeView {
	[self willChangeValueForKey:@"BadgeKey"];
	objc_setAssociatedObject(self, BadgeKey, badgeView, OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"BadgeKey"];
}

- (CHXBadgeView *)__badgeView {
	return objc_getAssociatedObject(self, &BadgeKey);
}

- (void)chx_setBadgeValue:(NSString *)badgeValue {
	if (![self __badgeView]) {
		CHXBadgeView *badeView = [CHXBadgeView new];
		[self addSubview:badeView];
		[self __setBadgeView:badeView];
	}
	
	CHXBadgeView *badgeView = [self __badgeView];
	badgeView.badgeValue = badgeValue;
	
	// Base on Frame
	[badgeView chx_setMidX:[self chx_width]];
	[badgeView chx_setMidY:0];
	
	// Base on auto layout
	UIView *superView = self;
	[badgeView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[superView addConstraints:@[[NSLayoutConstraint constraintWithItem:badgeView
															 attribute:NSLayoutAttributeCenterX
															 relatedBy:NSLayoutRelationEqual
																toItem:superView
															 attribute:NSLayoutAttributeRight
															multiplier:1
															  constant:0],
								[NSLayoutConstraint constraintWithItem:badgeView
															 attribute:NSLayoutAttributeCenterY
															 relatedBy:NSLayoutRelationEqual
																toItem:superView
															 attribute:NSLayoutAttributeTop
															multiplier:1
															  constant:0]
								]];
}

- (NSString *)chx_badgeValue {
	return [self __badgeView].badgeValue;
}

@end
