//
//  CHXBadgeView.m
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

- (void)pr_setBadgeView:(CHXBadgeView *)badgeView {
	[self willChangeValueForKey:@"BadgeKey"];
	objc_setAssociatedObject(self, &BadgeKey, badgeView, OBJC_ASSOCIATION_ASSIGN);
	[self didChangeValueForKey:@"BadgeKey"];
}

- (CHXBadgeView *)pr_badgeView {
	return objc_getAssociatedObject(self, &BadgeKey);
}

- (void)chx_setBadgeValue:(NSString *)badgeValue {
	CHXBadgeView *badgeView = [self pr_badgeView];
	if (!badgeView) {
		badgeView = [CHXBadgeView new];
		[self addSubview:badgeView];
		[self pr_setBadgeView:badgeView];
		
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
	
	badgeView.badgeValue = badgeValue;
	
	// Base on Frame
	[badgeView chx_setMidX:[self chx_width]];
	[badgeView chx_setMidY:0];
}

- (NSString *)chx_badgeValue {
	return [self pr_badgeView].badgeValue;
}

@end
