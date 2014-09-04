//
//  AccountManager.h
//  GettingStarted
//
//  Created by Moch on 9/4/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

+ (instancetype)sharedInstance;

- (NSString *)uniqueIdentifier;

@end
