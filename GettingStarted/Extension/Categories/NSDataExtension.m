//
//  NSDataExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/20/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "NSDataExtension.h"

@implementation NSDataExtension

@end


@implementation NSData (CHXJSON)

// Create a Foundation object from JSON data
- (id)chx_JSONObject {
	if (!self) {
		return nil;
	}
	NSError *error = nil;
	id object = [NSJSONSerialization JSONObjectWithData:self
												options:NSJSONReadingMutableLeaves
												  error:&error];
	if (error) {
		NSLog(@"Deserialized JSON string failed with error message '%@'.",
			  [error localizedDescription]);
	}
	
	return object;
}

// Generate JSON data from a Foundation object
+ (NSData *)chx_dataWithJSONObject:(id)object {
	if (!object) {
		return nil;
	}
	NSError *error = nil;
	NSData *data = [NSJSONSerialization dataWithJSONObject:object
												   options:NSJSONWritingPrettyPrinted
													 error:&error];
	if (error) {
		NSLog(@"Serialized JSON string failed with error message '%@'.",
			  [error localizedDescription]);
	}
	return data;
}

// Generate an JSON data from a property list
+ (NSData *)chx_dataWithPropertyList:(id)plist {
	NSError *error = nil;
	NSData *data = [NSPropertyListSerialization dataWithPropertyList:plist
															  format:NSPropertyListXMLFormat_v1_0
															 options:0
															   error:&error];
	if (error) {
		NSLog(@"Serialized PropertyList string failed with error message '%@'.",
			  [error localizedDescription]);
	}
	return data;
}

@end

@implementation NSData (CHXEncoding)

// Generate UTF-8 string from data
- (NSString *)chx_UTF8String {
	return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

// Generate ASCII string form data
- (NSString *)chx_ASCIIString {
	return [[NSString alloc] initWithData:self encoding:NSASCIIStringEncoding];
}

// Generate ISOLatin1 string form data
- (NSString *)chx_ISOLatin1String {
	return [[NSString alloc] initWithData:self encoding:NSISOLatin1StringEncoding];
}


@end