//
//  BadgeView.h
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 徽标

@interface VBadgeView : UIView

@property (nonatomic, assign) NSString *badgeValue;

@end


#pragma mark - 添加徽标

@interface UIView (VBadge)

/**
 *  设置徽标
 *
 *  @param badgeValue 徽标值
 */
- (void)v_setBadgeValue:(NSString *)badgeValue;

/**
 *  获取徽标
 *
 *  @return 徽标值
 */
- (NSString *)v_badgeValue;

@end
