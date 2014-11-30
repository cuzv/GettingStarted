//
//  UserDefaults.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/13/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXUserDefaults.h"

@implementation CHXUserDefaults

+ (void)setValue:(id)value forKey:(NSString *)key {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setValue:value forKey:key];
	[userDefaults synchronize];
}

+ (id)valueForKey:(NSString *)key {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return [userDefaults valueForKey:key];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setBool:value forKey:defaultName];
	[userDefaults synchronize];
}

+ (BOOL)boolForKey:(NSString *)defaultName {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return [userDefaults boolForKey:defaultName];
}

+ (void)echo {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *dictionary = [userDefaults dictionaryRepresentation];
	NSLog(@"%@", dictionary);
}

@end
