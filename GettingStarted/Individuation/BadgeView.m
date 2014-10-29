//
//  BadgeView.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "BadgeView.h"
#import "UIColorCategories.h"
#import "UIViewCategories.h"

#define kBadgeTextFont [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]

@interface BadgeView ()
@property (nonatomic, strong) UILabel *badgeLabel;
@end

@implementation BadgeView

- (instancetype)initWithOrigin:(CGPoint)origin {
    return [self initWithFrame:CGRectMake(origin.x, origin.y, 0, 0)];
}

- (instancetype)initWithOrigin:(CGPoint)origin unreadNumber:(NSUInteger)unreadNumber {
    if (self = [self initWithOrigin:origin]) {
        [self setUnreadNumber:unreadNumber];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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

- (void)setUnreadNumber:(NSUInteger)unreadNumber {
    _unreadNumber = unreadNumber;
    NSString *unreadStr = _unreadNumber > 99 ? @"99+" : [@(_unreadNumber) stringValue];
    self.width = [unreadStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)
                                         options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:kBadgeTextFont}
                                         context:nil].size.width + 4;
    self.width = self.width < 20 ? 20 : self.width;
    self.height = 20.0f;
    if(unreadNumber > 0) {
        [self setNeedsDisplay];
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
}

- (void)drawRect:(CGRect)rect {
    NSString *unreadStr = _unreadNumber > 99 ? @"99+" : [@(_unreadNumber) stringValue];
    _badgeLabel.text = unreadStr;
    self.layer.cornerRadius = self.width > self.height + 5 ? self.width / 3 : self.width / 2;
    [_badgeLabel drawTextInRect:self.bounds];
}


@end





