//
//  ReachabilityManager.m
//  GettingStarted
//
//  Created by Moch Xiao on 10/1/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXReachabilityManager.h"
#import "Reachability.h"

@interface CHXReachabilityManager ()
@property (nonatomic, weak) Reachability *reachability;
@end

@implementation CHXReachabilityManager

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
