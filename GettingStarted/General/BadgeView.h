//
//  BadgeView.h
//  Extension
//
//  Created by Moch on 7/31/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView

@property (nonatomic, assign) NSUInteger unreadNumber;

- (instancetype)initWithOrigin:(CGPoint)origin;
- (instancetype)initWithOrigin:(CGPoint)origin unreadNumber:(NSUInteger)unreadNumber;

@end
