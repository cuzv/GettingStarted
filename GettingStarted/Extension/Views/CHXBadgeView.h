//
//  BadgeView.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/29/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 徽标

@interface CHXBadgeView : UIView

@property (nonatomic, assign) NSString *badgeValue;

@end


#pragma mark - 添加徽标

@interface UIView (CHXBadge)

/**
 *  设置徽标
 *
 *  @param badgeValue 徽标值
 */
- (void)chx_setBadgeValue:(NSString *)badgeValue;

/**
 *  获取徽标
 *
 *  @return 徽标值
 */
- (NSString *)chx_badgeValue;

@end
