//
//  AssistanceMacro.h
//  GettingStarted
//
//  Created by Moch on 8/16/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#ifndef GettingStarted_AssistanceMacro_h
#define GettingStarted_AssistanceMacro_h

// A better version of NSLog
#if DEBUG
    #define NSLog(format, ...)                                                      \
    do {                                                                            \
        fprintf(stderr, "<%s : %d> %s\n",                                           \
        [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
        __LINE__, __func__);                                                        \
        (NSLog)((format), ##__VA_ARGS__);                                           \
    } while (0)
#else
    #define NSLog(format, ...) NSLog(@"")
#endif

// get image
#define CHImage(image) [UIImage imageNamed:image]

// size
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define CHRGBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define CHCurrentDeviceRealSize [[[UIScreen mainScreen] currentMode] size]
#define CHNeedHightForiPhone5 568
#define CHNeedHightForiPhone4 480
#define CHScreenHeight (iPhone5 ? 568 : 480)
#define CHStatusBarHeight (is_iOS7 ? 20 : 0)

// app delegate
#define AppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

// format timestamp
#define CHFormatTime(date) [NSString stringWithFormat:@"%.0lf",([date timeIntervalSince1970]*1000)]
// format time
#define CHDateFromTimeInterval [NSDate dateWithTimeIntervalSince1970:timeInterval/1000]

// make singletion
#define MakeSingleton(__ClassType__)            \
+ (__ClassType__ *)sharedInstance {             \
    static dispatch_once_t pred;                \
    static __ClassType__ *sharedInstance = nil; \
    dispatch_once(&pred, ^{                     \
        sharedInstance = [LimitInput new];      \
    });                                         \
    return sharedInstance;                      \
}

// make property for class


#endif
