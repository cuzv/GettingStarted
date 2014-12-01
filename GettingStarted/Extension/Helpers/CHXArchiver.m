//
//  Archiver.m
//  GettingStarted
//
//  Created by Moch Xiao on 9/3/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXArchiver.h"

@implementation CHXArchiver

+ (BOOL)archiveValue:(id)value forKey:(NSString *)key {
    if (!value) {
        // Remove value for key
        return [self __cleanPersistenceValueForKey:key];
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
    NSString *filePath = [self __persistencePathWithKey:key];
    if (!filePath) {
        return NO;
    }
    return [base64String writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

+ (NSString *)__persistencePathWithKey:(NSString *)key {
    return [[self __persistencePath] stringByAppendingPathComponent:key];
}

+ (NSString *)__persistencePath {
	// TODO
	NSString *userFolder = nil;// [[AccountManager sharedInstance] uniqueIdentifier];
    if (!userFolder) {
        NSLog(@"Datas will persistence to common area!");
        userFolder = @"CommonDatas";
    }
    
    NSString *path = [[self __applicationDocumentDirectory] stringByAppendingPathComponent:userFolder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return path;
}

+ (NSString *)__applicationDocumentDirectory {
    // NSCachesDirectory will not pushed on iClound
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (id)archivedValueForKey:(NSString *)key {
    NSError *error = nil;
    NSString *unarchiverString = [[NSString alloc] initWithContentsOfFile:[self __persistencePathWithKey:key] encoding:NSUTF8StringEncoding error:&error];
    if (!unarchiverString) {
        NSLog(@"Persistence datas Not Found!");
        return nil;
    }
    
    NSData *unarchiverData = [[NSData alloc] initWithBase64EncodedString:unarchiverString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    // Connect unarchiver data and unarchiver
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
    
    return [unarchiver decodeObjectForKey:key];
}

+ (BOOL)__cleanPersistenceValueForKey:(NSString *)key {
    return [self __cleanupForPath:[self __persistencePathWithKey:key]];
}

+ (BOOL)cleanup {
    return [self __cleanupForPath:[self __persistencePath]];
}

+ (BOOL)__cleanupForPath:(NSString *)path {
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
