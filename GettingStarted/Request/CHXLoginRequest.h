//
//  CHXLoginRequest.h
//  GettingStarted
//
//  Created by Moch Xiao on 12/1/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXBaseRequest.h"

@interface CHXLoginRequest : CHXBaseRequest

- (instancetype)initWithUsername:(NSString *)userName password:(NSString *)password;

@end
