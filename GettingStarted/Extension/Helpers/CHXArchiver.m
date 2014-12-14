//
//  CHXArchiver.m
//  GettingStarted
//
//  Created by Moch Xiao on 9/3/14.
//	Copyright (c) 2014 Moch Xiao (http://www.github.com/atcuan)
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
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
