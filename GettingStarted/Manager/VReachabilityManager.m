//
//  ReachabilityManager.m
//  GettingStarted
//
//  Created by Moch on 10/1/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "VReachabilityManager.h"
#import "Reachability.h"

@interface VReachabilityManager ()
@property (nonatomic, weak) Reachability *reachability;
@end

@implementation VReachabilityManager

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (BOOL)startMonitoringUsingBlock:(NetowrkingStatus)callback {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    reachability.unreachableBlock = ^(Reachability * reachability) {
        callback(NO);
    };
    reachability.reachableBlock = ^(Reachability * reachability) {
        callback(YES);
    };
    self.reachability = reachability;
    
    return [reachability startNotifier];
}

- (void)stopMonitoring {
    [self.reachability stopNotifier];
    self.reachability = nil;
}

@end
