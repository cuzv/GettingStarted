//
//  VerificationManager.h
//  WFarm
//
//  Created by Moch on 8/20/14.
//  Copyright (c) 2014 BSG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVerificationManager : NSObject

+ (BOOL)verifyingPhone:(NSString *)phoneNumber;
+ (BOOL)verifyingPassword:(NSString *)password;
+ (BOOL)verifyingPassword:(NSString *)password repeat:(NSString *)repeat;
+ (BOOL)verifyingAuthCode:(NSString *)authCode;

@end
