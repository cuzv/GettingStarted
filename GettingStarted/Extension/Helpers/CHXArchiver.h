//
//  Archiver.m
//  GettingStarted
//
//  Created by Moch Xiao on 9/3/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHXArchiver : NSObject

+ (BOOL)archiveValue:(id)value forKey:(NSString *)key;
+ (id)archivedValueForKey:(NSString *)key;
+ (BOOL)cleanup;

@end
