//
//  UIView+HUD.h
//  GettingStarted
//
//  Created by Moch on 9/3/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGProgressHUD.h"

@interface UIView (HUD)

- (void)showHUDWithMessage:(NSString *)message;
- (void)showLoadingHUD;
- (void)showLoadingHUDWithMessage:(NSString *)message;

- (void)showUploadingHUD;
- (void)showDownloadingHUD;
- (void)updateHUDProgress:(NSUInteger)progress;

// Flow two messages are just for test, you should not call these messages directly
- (void)testUploadingHUD;
- (void)testDownloadingHUD;

- (void)showSuccessHUDWithMessage:(NSString *)message;
- (void)showFailureHUDWithMessage:(NSString *)message;

- (void)showCancelableHUDWithMessage:(NSString *)message cancelConfirmMessage:(NSString *)confirmMessage;

- (void)dismissHUD;

@end
