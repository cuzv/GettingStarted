//
//  CHXRequestConfiguration.m
//  GettingStarted
//
//  Created by Moch Xiao on 12/10/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXRequestConfiguration.h"

@implementation CHXRequestConfiguration

+ (instancetype)sharedInstance {
	static CHXRequestConfiguration *_sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [self new];
	});
	
	return _sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		
	}
	
	return self;
}

#pragma mark - 

// TODO
+ (void)setLogOn {}

@end
