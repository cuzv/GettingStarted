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

    // convert to base64
    NSString *base64String = [archiverMutableData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    NSError *error = nil;
    return [base64String writeToFile:[self persistencePath] atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

+ (NSString *)persistencePath {
    return [[self applicationDocumentDirectory] stringByAppendingPathComponent:@"PersistenceDatas"];
}

+ (NSString *)applicationDocumentDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (id)persistenceValueForKey:(NSString *)key {
    NSError *error = nil;
    NSString *unarchiverString = [[NSString alloc] initWithContentsOfFile:[self persistencePath] encoding:NSUTF8StringEncoding error:&error];
    NSData *unarchiverData = [[NSData alloc] initWithBase64EncodedString:unarchiverString options:NSDataBase64DecodingIgnoreUnknownCharacters];

    // Connect unarchiver data and unarchiver
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];

    return [unarchiver decodeObjectForKey:key];
}

+ (BOOL)cleanup {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager isDeletableFileAtPath:[self persistencePath]]) {
        NSError *error = nil;
        BOOL success = [fileManager removeItemAtPath:[self persistencePath] error:&error];
        return success;
    };
    
    return NO;
}


@end
