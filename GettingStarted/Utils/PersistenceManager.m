//
//  PersistenceManager.m
//  GettingStarted
//
//  Created by Moch on 9/3/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "PersistenceManager.h"
#import "NSString+Hashes.h"

@implementation PersistenceManager

+ (BOOL)persistenceValue:(id)value forKey:(NSString *)key {
    if (!value) {
        // Remove value for key
        return [self cleanPersistenceValueForKey:key];
    }
    // Add value for key
    // Create data container
    NSMutableData *archiverMutableData = [NSMutableData new];
    // Connect data container and archiver
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverMutableData];
    [archiver encodeObject:value forKey:key];
    // This step is very import
    [archiver finishEncoding];
    
    // convert to base64
    NSString *base64String = [archiverMutableData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSError *error = nil;
    return [base64String writeToFile:[self persistencePathWithKey:key] atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

+ (NSString *)persistencePathWithKey:(NSString *)key {
    return [[self persistencePath] stringByAppendingPathComponent:key];
}

+ (NSString *)persistencePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[self applicationDocumentDirectory] stringByAppendingPathComponent:@"PersistenceDatas"];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return path;
}

+ (NSString *)applicationDocumentDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (id)persistenceValueForKey:(NSString *)key {
    NSError *error = nil;
    NSString *unarchiverString = [[NSString alloc] initWithContentsOfFile:[self persistencePathWithKey:key] encoding:NSUTF8StringEncoding error:&error];
    NSData *unarchiverData = [[NSData alloc] initWithBase64EncodedString:unarchiverString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    // Connect unarchiver data and unarchiver
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
    
    return [unarchiver decodeObjectForKey:key];
}

+ (BOOL)cleanPersistenceValueForKey:(NSString *)key {
    return [self cleanupForPath:[self persistencePathWithKey:key]];
}

+ (BOOL)cleanup {
    return [self cleanupForPath:[self persistencePath]];
}

+ (BOOL)cleanupForPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager isDeletableFileAtPath:path]) {
        NSError *error = nil;
        BOOL success = [fileManager removeItemAtPath:path error:&error];
        return success;
    };
    
    return NO;
}


@end
