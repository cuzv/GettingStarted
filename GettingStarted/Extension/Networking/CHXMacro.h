//
//  CHXMacro.h
//  GettingStarted
//
//  Created by Moch Xiao on 12/12/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#ifndef GettingStarted_CHXMacro_h
#define GettingStarted_CHXMacro_h

#if DEBUG
#define NSLog(FORMAT, ...) \
do { \
fprintf(stderr,"%s: %d: %s\n", \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, \
[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]); \
} while(0)
#else
#define NSLog(FORMAT, ...) NSLog(@"")
#endif

#endif
