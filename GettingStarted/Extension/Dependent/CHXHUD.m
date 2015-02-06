//
//  CHXHUD.m
//  GettingStarted
//
//  Created by Moch Xiao on 2/6/15.
//  Copyright (c) 2015 Foobar. All rights reserved.
//

#import "CHXHUD.h"
#import "JGProgressHUD.h"
#import "JGProgressHUDFadeZoomAnimation.h"

static JGProgressHUD *HUD;
static UIView *presentView;

@implementation CHXHUD

+ (void)showHUDWithMessage:(NSString *)message {
    if (HUD.targetView) {
        return;
    }
    
    JGProgressHUD *staticHUD = [self staticHUD];
    staticHUD.indicatorView = nil;
    staticHUD.textLabel.text = message;
    [staticHUD dismissAfterDelay:2.0f];
    [staticHUD showInView:presentView animated:YES];
}

+ (void)showLoadingHUDWithMessage:(NSString *)message {
    if (HUD.targetView) {
        return;
    }
    
    JGProgressHUD *staticHUD = [self staticHUD];
    staticHUD.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;
    JGProgressHUDFadeZoomAnimation *animation = [JGProgressHUDFadeZoomAnimation animation];
    staticHUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    staticHUD.HUDView.layer.shadowColor = [UIColor blackColor].CGColor;
    staticHUD.HUDView.layer.shadowOffset = CGSizeZero;
    staticHUD.HUDView.layer.shadowOpacity = 0.4f;
    staticHUD.HUDView.layer.shadowRadius = 8.0f;
    staticHUD.animation = animation;
    staticHUD.textLabel.text = message.length ? message : @"加载中...";
    [staticHUD showInView:presentView animated:YES];
}

+ (void)showLoadingHUD {
    if (HUD.targetView) {
        return;
    }
    
    JGProgressHUD *staticHUD = [self staticHUD];
    [staticHUD showInView:presentView animated:YES];
}

+ (void)removeHUDIfExist {
    if (HUD.targetView) {
        [HUD dismissAnimated:YES];
    }
}

+ (JGProgressHUD *)staticHUD {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleExtraLight];
        HUD.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        HUD.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;
        HUD.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        presentView = [UIApplication sharedApplication].keyWindow;
    });
    
    return HUD;
}

@end
