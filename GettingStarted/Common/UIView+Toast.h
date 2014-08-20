//
//  UIView+Toast.h
//  GettingStarted
//
//  Created by Moch on 8/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHToastAppearOrientation) {
    CHToastAppearOrientationTop,
    CHToastAppearOrientationBottom
};

@interface UIView (Toast)

// 吐司框，自动消失
+ (void)toastWithMessage:(NSString *)message;
+ (void)toastWithMessage:(NSString *)message appearOrientation:(CHToastAppearOrientation)orientation;

@end
