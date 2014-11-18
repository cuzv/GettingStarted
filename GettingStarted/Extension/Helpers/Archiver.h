//
//  Archiver.m
//  GettingStarted
//
//  Created by Moch on 9/3/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Archiver : NSObject

+ (BOOL)archiveValue:(id)value forKey:(NSString *)key;
+ (id)archivedValueForKey:(NSString *)key;
+ (BOOL)cleanup;

@end
