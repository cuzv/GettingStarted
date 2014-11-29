//
//  AccountManager.m
//  GettingStarted
//
//  Created by Moch on 9/4/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "VAccountManager.h"

static VAccountManager *sharedInstance;

@implementation VAccountManager

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
