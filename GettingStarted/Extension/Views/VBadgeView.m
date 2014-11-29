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
		self.backgroundColor = [UIColor colorWithRGBA:@[@255, @65, @73, @1]];
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
	self.width = calculateWidth < kBadgeViewHeight ? kBadgeViewHeight : calculateWidth;
	self.height = kBadgeViewHeight;
	
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
	return CGSizeMake(self.width, self.height);
}

@end





