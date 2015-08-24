//
//  UIView+CHXHUD.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/cuzv).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
