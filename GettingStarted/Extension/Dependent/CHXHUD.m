//
//  CHXHUD.m
//  GettingStarted
//
//  Created by Moch Xiao on 2015-02-06.
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
    staticHUD.contentView.backgroundColor = [UIColor yellowColor];
    staticHUD.textLabel.backgroundColor = [UIColor clearColor];
    staticHUD.contentView.backgroundColor = [UIColor clearColor];
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
    staticHUD.indicatorView = [[JGProgressHUDIndicatorView alloc] initWithContentView:({
        UIView *view = [UIView new];
        view.bounds = CGRectMake(0, 0, 50, 50);
        view;
    })];
    [staticHUD.indicatorView.contentView addSubview:({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        view.layer.contents = (id)[[UIImage imageNamed:@"jg_hud_error"] CGImage];
        view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        view;
    })];
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
//        HUD.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.35];
        HUD.backgroundColor = [UIColor clearColor];
        HUD.contentView.backgroundColor = [UIColor clearColor];
        HUD.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;
        HUD.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        presentView = [UIApplication sharedApplication].keyWindow;
    });
    
    return HUD;
}

@end
