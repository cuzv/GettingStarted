//
//  NSDictionaryExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/20/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "NSDictionaryExtension.h"

@implementation NSDictionaryExtension

@end

@implementation NSDictionary (CHXURLPath)

// Convert dictionary to url string
- (NSString *)chx_URLParameterString {
	NSAssert([self isKindOfClass:[NSDictionary class]],
			 @"The input parameters is not dictionary type!");
	
	NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithDictionary:self];
	NSMutableString *URLParamMutableString = [NSMutableString new];
	[paramDic keysOfEntriesWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id key, id obj, BOOL *stop) {
		[URLParamMutableString appendFormat:@"%@=%@&", key, obj];
		return NO;
	}];
	NSString *URLParamString = [URLParamMutableString substringToIndex:URLParamMutableString.length - 1];
	
	return URLParamString;
}

@end