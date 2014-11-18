//
//  ReachabilityManager.m
//  GettingStarted
//
//  Created by Moch on 10/1/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "ReachabilityManager.h"
#import "Reachability.h"

@interface ReachabilityManager ()
@property (nonatomic, weak) Reachability *reachability;
@end

@implementation ReachabilityManager

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
