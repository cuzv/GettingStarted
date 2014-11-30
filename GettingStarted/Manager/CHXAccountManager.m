//
//  AccountManager.m
//  GettingStarted
//
//  Created by Moch Xiao on 9/4/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXAccountManager.h"

static CHXAccountManager *sharedInstance;

@implementation CHXAccountManager

+ (id)copyWithZone:(struct _NSZone *)zone {
    return self;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

// TODO
- (NSString *)uniqueIdentifier {
    return nil;
}


@end
