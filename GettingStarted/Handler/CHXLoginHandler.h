//
//  CHXLoginHandler.h
//  GettingStarted
//
//  Created by Moch Xiao on 12/1/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHXUser.h"

typedef void(^HandleSuccessBlock)(id model);
typedef void(^HandleFailureBlock)(NSString *errorDescription);

@interface CHXLoginHandler : NSObject

- (void)hanldeParmaters:(CHXUser *)parmaters withSuccess:(HandleSuccessBlock)success failure:(HandleFailureBlock)failure;

@end
