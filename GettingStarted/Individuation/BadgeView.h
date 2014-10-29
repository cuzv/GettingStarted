//
//  BadgeView.h
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 徽标

@interface BadgeView : UIView

/**
 *  未读数量
 */
@property (nonatomic, assign) NSUInteger unreadNumber;

- (instancetype)initWithOrigin:(CGPoint)origin;
- (instancetype)initWithOrigin:(CGPoint)origin unreadNumber:(NSUInteger)unreadNumber;

@end


