//
//  CHXHUD.h
//  GettingStarted
//
//  Created by Moch Xiao on 2/6/15.
//  Copyright (c) 2015 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHXHUD : NSObject

+ (void)showHUDWithMessage:(NSString *)message;
+ (void)showLoadingHUDWithMessage:(NSString *)message;
+ (void)showLoadingHUD;
+ (void)removeHUDIfExist;

@end
