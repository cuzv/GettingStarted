//
//  UIView+HUD.h
//  GettingStarted
//
//  Created by Moch on 9/3/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGProgressHUD.h"

@interface UIView (VHUD)

- (void)v_showHUDWithMessage:(NSString *)message;
- (void)v_showLoadingHUD;
- (void)v_showLoadingHUDWithMessage:(NSString *)message;

- (void)v_showUploadingHUD;
- (void)v_showDownloadingHUD;
- (void)v_updateHUDProgress:(NSUInteger)progress;

// Flow two messages are just for test, you should not call these messages directly
- (void)v_testUploadingHUD;
- (void)v_testDownloadingHUD;

- (void)v_showSuccessHUDWithMessage:(NSString *)message;
- (void)v_showFailureHUDWithMessage:(NSString *)message;

- (void)v_showCancelableHUDWithMessage:(NSString *)message cancelConfirmMessage:(NSString *)confirmMessage;

- (void)v_dismissHUD;

@end
