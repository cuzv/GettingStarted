//
//  ReachabilityManager.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/1/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetowrkingStatus)(BOOL);

@interface CHXReachabilityManager : NSObject

- (BOOL)startMonitoringUsingBlock:(NetowrkingStatus)callback;
- (void)stopMonitoring;

@end

