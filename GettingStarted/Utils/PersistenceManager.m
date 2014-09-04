//
//  PersistenceManager.m
//  GettingStarted
//
//  Created by Moch on 9/3/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "PersistenceManager.h"
#import "AccountManager.h"

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
    NSString *filePath = [self persistencePathWithKey:key];
    if (!filePath) {
        return NO;
    }
    return [base64String writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

+ (NSString *)persistencePathWithKey:(NSString *)key {
    NSString *persistencePath = [self persistencePath];
    if (!persistencePath) {
        return nil;
    }
    
    return [persistencePath stringByAppendingPathComponent:key];
}

+ (NSString *)persistencePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *userFolder = [[AccountManager sharedInstance] uniqueIdentifier];
    if (!userFolder) {
        NSLog(@"Can not persistence data for anonymous user");
        return nil;
    }
    NSString *path = [[self applicationDocumentDirectory] stringByAppendingPathComponent:userFolder];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return path;
}

+ (NSString *)applicationDocumentDirectory {
    // NSCachesDirectory will not pushed on iClound
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (id)persistenceValueForKey:(NSString *)key {
    NSError *error = nil;
    NSString *filePath = [self persistencePathWithKey:key];
    if (!filePath) {
        NSLog(@"Persistence datas Not Found!");
        return nil;
    }
    NSString *unarchiverString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
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
    if (!path) {
        NSLog(@"Persistence datas Not Found!");
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager isDeletableFileAtPath:path]) {
        NSError *error = nil;
        BOOL success = [fileManager removeItemAtPath:path error:&error];
        return success;
    };
    
    return NO;
}


@end
