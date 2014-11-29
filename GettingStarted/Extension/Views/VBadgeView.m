//
//  BadgeView.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "VBadgeView.h"
#import "UIColorExtension.h"
#import "UIViewExtension.h"

#define kBadgeTextFont [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]
static CGFloat kBadgeViewHeight = 18.0f;

@interface VBadgeView ()
@property (nonatomic, strong) UILabel *badgeLabel;
@end

@implementation VBadgeView

- (instancetype)init {
	if (self = [super init]) {
		self.backgroundColor = [UIColor v_colorWithRGBA:@[@255, @65, @73, @1]];
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
	[self v_setWidth:calculateWidth < kBadgeViewHeight ? kBadgeViewHeight : calculateWidth];
	[self v_setHeight:kBadgeViewHeight];
	
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
	return CGSizeMake([self v_width], [self v_height]);
}

@end





#pragma mark - 添加徽标

#import "VBadgeView.h"
#import <objc/runtime.h>

static const void *BadgeKey = &BadgeKey;

@implementation UIView (VBadge)

- (void)v_setBadgeView:(VBadgeView *)badgeView {
	[self willChangeValueForKey:@"BadgeKey"];
	objc_setAssociatedObject(self, BadgeKey, badgeView, OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"BadgeKey"];
}

- (VBadgeView *)v_badgeView {
	return objc_getAssociatedObject(self, &BadgeKey);
}

- (void)v_setBadgeValue:(NSString *)badgeValue {
	if (![self v_badgeView]) {
		VBadgeView *badeView = [VBadgeView new];
		[self addSubview:badeView];
		[self v_setBadgeView:badeView];
	}
	
	VBadgeView *badgeView = [self v_badgeView];
	badgeView.badgeValue = badgeValue;
	
	// Base on Frame
	[badgeView v_setMidX:[self v_width]];
	[badgeView v_setMidY:0];
	
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

- (NSString *)v_badgeValue {
	return [self v_badgeView].badgeValue;
}

@end
