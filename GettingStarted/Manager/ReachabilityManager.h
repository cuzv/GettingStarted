//
//  ReachabilityManager.h
//  GettingStarted
//
//  Created by Moch on 10/1/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetowrkingStatus)(BOOL);

@interface ReachabilityManager : NSObject

- (BOOL)startMonitoringUsingBlock:(NetowrkingStatus)callback;
- (void)stopMonitoring;

@end

