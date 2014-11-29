//
//  UIView+HUD.m
//  GettingStarted
//
//  Created by Moch on 9/3/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIView+VHUD.h"
#import <objc/runtime.h>
#import "JGProgressHUD.h"
#import "JGProgressHUDFadeZoomAnimation.h"
#import "JGProgressHUDPieIndicatorView.h"
#import "JGProgressHUDSuccessIndicatorView.h"
#import "JGProgressHUDRingIndicatorView.h"
#import "JGProgressHUDErrorIndicatorView.h"
#import "JGProgressHUDIndeterminateIndicatorView.h"

#define kDelayTimeInterval 2.0f

static const void *UIViewHUDKey = &UIViewHUDKey;

@interface UIView ()
@property(nonatomic, weak) JGProgressHUD *HUD;
@end

@implementation UIView (VHUD)

- (void)setHUD:(JGProgressHUD *)HUD {
    [self willChangeValueForKey:@"UIViewHUDKey"];
    objc_setAssociatedObject(self, UIViewHUDKey, HUD, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"UIViewHUDKey"];
}

- (JGProgressHUD *)HUD {
    return objc_getAssociatedObject(self, &UIViewHUDKey);
}

- (JGProgressHUD *)HUDWithMessage:(NSString *)message {
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;
    HUD.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    HUD.textLabel.text = message;
    self.HUD = HUD;
    return HUD;
}

- (void)v_showHUDWithMessage:(NSString *)message {
    JGProgressHUD *HUD = [self HUDWithMessage:message];
    HUD.indicatorView = nil;
    [HUD dismissAfterDelay:kDelayTimeInterval];
    [HUD showInView:self];
}

- (void)v_showLoadingHUD {
    JGProgressHUD *HUD = [self HUDWithMessage:nil];
    [HUD showInView:self];
}

- (void)v_showLoadingHUDWithMessage:(NSString *)message {
    JGProgressHUD *HUD = [self HUDWithMessage:message];
    HUD.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;
    JGProgressHUDFadeZoomAnimation *animation = [JGProgressHUDFadeZoomAnimation animation];
    HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    HUD.HUDView.layer.shadowColor = [UIColor blackColor].CGColor;
    HUD.HUDView.layer.shadowOffset = CGSizeZero;
    HUD.HUDView.layer.shadowOpacity = 0.4f;
    HUD.HUDView.layer.shadowRadius = 8.0f;
    HUD.animation = animation;
    HUD.textLabel.text = message ? : @"Loading...";
    [HUD showInView:self];
}

- (void)v_showUploadingHUD {    
    JGProgressHUD *HUD = [self HUDWithMessage:nil];
    HUD.indicatorView = [[JGProgressHUDRingIndicatorView alloc] initWithHUDStyle:HUD.style];
    HUD.detailTextLabel.text = @"0% Complete";
    HUD.textLabel.text = @"Uploading...";
    HUD.layoutChangeAnimationDuration = 0.0;
    [HUD showInView:self];
}

- (void)v_showDownloadingHUD {
    JGProgressHUD *HUD = [self HUDWithMessage:nil];
    HUD.indicatorView = [[JGProgressHUDPieIndicatorView alloc] initWithHUDStyle:HUD.style];
    HUD.detailTextLabel.text = @"0% Complete";
    HUD.textLabel.text = @"Downloading...";
    HUD.layoutChangeAnimationDuration = 0.0;
    [HUD showInView:self];
}

- (void)v_updateHUDProgress:(NSUInteger)progress {
    [self incrementHUD:self.HUD progress:progress];
}

- (void)incrementHUD:(JGProgressHUD *)HUD progress:(NSUInteger)progress {
    [HUD setProgress:progress/100.0f animated:NO];
    HUD.detailTextLabel.text = [NSString stringWithFormat:@"%@%% Complete", @(progress)];
    
    if (progress == 100) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            HUD.textLabel.text = @"Success";
            HUD.detailTextLabel.text = nil;
            HUD.layoutChangeAnimationDuration = 0.3;
            HUD.indicatorView = [JGProgressHUDSuccessIndicatorView new];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUD dismiss];
        });
    }
}

- (void)v_testUploadingHUD {
    [self v_showUploadingHUD];
    [self updateUI];
}

- (void)v_testDownloadingHUD {
    [self v_showDownloadingHUD];
    [self updateUI];
}

- (void)updateUI {
    __block int completeness = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 0.3 * NSEC_PER_SEC / 18, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (completeness != 100) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self v_updateHUDProgress:completeness];
            });
            completeness++;
        } else {
            dispatch_source_cancel(timer);
        }
    });
    dispatch_source_set_cancel_handler(timer, ^{
        //        dispatch_release(timer);
    });
    dispatch_resume(timer);
}

- (void)v_showSuccessHUDWithMessage:(NSString *)message {
    JGProgressHUD *HUD = [self HUDWithMessage:message];
    HUD.square = YES;
    HUD.indicatorView = [JGProgressHUDSuccessIndicatorView new];
    HUD.textLabel.text = message ? : @"Success";
    [HUD dismissAfterDelay:kDelayTimeInterval];
    [HUD showInView:self];
}

- (void)v_showFailureHUDWithMessage:(NSString *)message {
    JGProgressHUD *HUD = [self HUDWithMessage:message];
    HUD.square = YES;
    HUD.indicatorView = [JGProgressHUDErrorIndicatorView new];
    HUD.textLabel.text = message ? : @"Failure";
    [HUD dismissAfterDelay:kDelayTimeInterval];
    [HUD showInView:self];
}

- (void)v_showCancelableHUDWithMessage:(NSString *)message cancelConfirmMessage:(NSString *)confirmMessage {
    JGProgressHUD *HUD = [self HUDWithMessage:nil];
    HUD.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;
    HUD.textLabel.text = message ? : @"Loading very long...";
    
    __block BOOL confirmationAsked = NO;
    HUD.tapOnHUDViewBlock = ^(JGProgressHUD *hud) {
        if (confirmationAsked) {
            [hud dismiss];
        } else {
            hud.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init];
            hud.textLabel.text = confirmMessage ? : @"Cancel ?";
            hud.HUDView.layer.shadowColor = [UIColor redColor].CGColor;
            hud.HUDView.layer.shadowOffset = CGSizeZero;
            hud.HUDView.layer.shadowOpacity = 0.0f;
            hud.HUDView.layer.shadowRadius = 8.0f;
            confirmationAsked = YES;

            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
            animation.fromValue = @(0.0f);
            animation.toValue = @(0.5f);
            animation.repeatCount = HUGE_VALF;
            animation.autoreverses = YES;
            animation.duration = 0.75f;
            [hud.HUDView.layer addAnimation:animation forKey:@"glow"];
            
            __weak __typeof(hud) weakHUD = hud;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (weakHUD && confirmationAsked) {
                    confirmationAsked = NO;
                    __strong __typeof(weakHUD) strongHUD = weakHUD;
                    strongHUD.indicatorView = [[JGProgressHUDIndeterminateIndicatorView alloc] initWithHUDStyle:strongHUD.style];
                    strongHUD.textLabel.text = message ? : @"Loading very long...";
                    [hud.HUDView.layer removeAnimationForKey:@"glow"];
                }
            });
        }
    };
    
    HUD.tapOutsideBlock = ^(JGProgressHUD *h) {
        if (confirmationAsked) {
            confirmationAsked = NO;
            h.indicatorView = [[JGProgressHUDIndeterminateIndicatorView alloc] initWithHUDStyle:h.style];
            h.textLabel.text = message ? : @"Loading very long...";
            [h.HUDView.layer removeAnimationForKey:@"glow"];
        }
    };
    
    [HUD showInView:self];
}



- (void)v_dismissHUD {
    [self.HUD dismiss];
    self.HUD = nil;
}

@end
