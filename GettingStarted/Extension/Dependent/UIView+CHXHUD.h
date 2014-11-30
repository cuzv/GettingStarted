//
//  UIView+HUD.h
//  GettingStarted
//
//  Created by Moch Xiao on 9/3/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGProgressHUD.h"

@interface UIView (CHXHUD)

- (void)chx_showHUDWithMessage:(NSString *)message;
- (void)chx_showLoadingHUD;
- (void)chx_showLoadingHUDWithMessage:(NSString *)message;

- (void)chx_showUploadingHUD;
- (void)chx_showDownloadingHUD;
- (void)chx_updateHUDProgress:(NSUInteger)progress;

// Flow two messages are just for test, you should not call these messages directly
- (void)chx_testUploadingHUD;
- (void)chx_testDownloadingHUD;

- (void)chx_showSuccessHUDWithMessage:(NSString *)message;
- (void)chx_showFailureHUDWithMessage:(NSString *)message;

- (void)chx_showCancelableHUDWithMessage:(NSString *)message cancelConfirmMessage:(NSString *)confirmMessage;

- (void)chx_dismissHUD;

@end
