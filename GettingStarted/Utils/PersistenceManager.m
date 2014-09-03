//
//  PersistenceManager.m
//  GettingStarted
//
//  Created by Moch on 9/3/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "PersistenceManager.h"

@implementation PersistenceManager

+ (BOOL)persistenceValue:(id)value forKey:(NSString *)key {
    if (!value) {
        // Remove value for key
        value = [NSNull null];
    }
    // Add value for key
    // Create data container
    NSMutableData *archiverMutableData = [NSMutableData new];
    // Connect data container and archiver
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverMutableData];
    [archiver encodeObject:value forKey:key];
    // This step is very import
    [archiver finishEncoding];
    return [archiverMutableData writeToFile:[self persistencePath] atomically:YES];
}

+ (NSString *)persistencePath {
    return [[self applicationDocumentDirectory] stringByAppendingPathComponent:@"PersistenceManager.plist"];
}

+ (NSString *)applicationDocumentDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (id)persistenceValueForKey:(NSString *)key {
    // Connect unarchiver and data
    NSData *unarchiverData = [[NSData alloc] initWithContentsOfFile:[self persistencePath]];
    // Connect unarchiver data and unarchiver
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
    return [unarchiver decodeObjectForKey:key];
}


@end
