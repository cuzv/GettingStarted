//
//  CodeHelper.h
//  GettingStarted
//
//  Created by Moch on 11/18/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#ifndef GettingStarted_CodeHelper_h
#define GettingStarted_CodeHelper_h

// Colors
#define BlackColor [UIColor blackColor]
#define DarkGrayColor [UIColor darkGrayColor]
#define LightGrayColor [UIColor lightGrayColor]
#define WhiteColor [UIColor whiteColor]
#define GrayColor [UIColor grayColor]
#define RedColor [UIColor redColor]
#define GreenColor [UIColor greenColor]
#define BlueColor [UIColor blueColor]
#define CyanColor [UIColor cyanColor]
#define YellowColor [UIColor yellowColor]
#define MagentaColor [UIColor magentaColor]
#define OrangeColor [UIColor orangeColor]
#define PurpleColor [UIColor purpleColor]
#define BrownColor [UIColor brownColor]
#define ClearColor [UIColor clearColor]

// Fonts
#define FontHeadLine [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]
#define FontBody [UIFont preferredFontForTextStyle:UIFontTextStyleBody]
#define FontSubheadline [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
#define FontFootnote [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]
#define FontCaption1 [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]
#define FontCaption2 [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]

// Devices
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

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

#endif
