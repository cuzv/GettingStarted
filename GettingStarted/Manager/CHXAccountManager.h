//
//  AccountManager.h
//  GettingStarted
//
//  Created by Moch Xiao on 9/4/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHXAccountManager : NSObject

+ (instancetype)sharedInstance;

- (NSString *)uniqueIdentifier;

@end
