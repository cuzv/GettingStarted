//
//  CodeHelper.h
//  GettingStarted
//
//  Created by Moch on 11/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@class UIView, UINavigationBar, UITabBar, UIImage, NSError;

@interface VGlobalServices : NSObject

#pragma mark -

/**
 *  获取设备系统版本号，Apple code
 *
 *  @return 设备系统版本号
 */
NSUInteger v_deviceSystemMajorVersion();

/**
 *  获取 App build number
 *
 *  @return App build number
 */
float v_appBuildNumber();

/**
 *  获取 App 版本号
 *
 *  @return App 版本号
 */
float v_appVersionNumber();

#pragma mark -

/**
 *  获取设备屏幕dounds
 *
 *  @return 设备屏幕dounds
 */
struct CGRect v_screenBounds();

/**
 *  获取屏幕宽度
 *
 *  @return 屏幕宽度
 */
CGFloat v_screenWidth();

/**
 *  获取屏幕高度
 *
 *  @return 屏幕高度
 */
CGFloat v_screenHeight();

#pragma mark -

/**
 *  角度转弧度
 *
 *  @param angle 角度值
 *
 *  @return 弧度值
 */
CGFloat v_radianFromAngle(CGFloat angle);

/**
 *  弧度转角度
 *
 *  @param radian 弧度
 *
 *  @return 角度
 */
CGFloat v_angleFromRadian(CGFloat radian);

#pragma mark - 

/**
 *  获取沙盒文档目录
 *
 *  @return 沙盒文档目录
 */
NSString *v_documentDirectory();

/**
 *  获取沙盒缓存目录
 *
 *  @return 沙盒缓存目录
 */
NSString *v_cachesDirectory();

/**
 *  获取沙盒下载目录
 *
 *  @return 沙盒下载目录
 */
NSString *v_downloadsDirectory();

/**
 *  获取沙盒电影目录
 *
 *  @return 沙盒电影目录
 */
NSString *v_moviesDirectory();

/**
 *  获取沙盒音乐目录
 *
 *  @return 沙盒音乐目录
 */
NSString *v_musicDirectory();

/**
 *  获取沙盒图片目录
 *
 *  @return 沙盒图片目录
 */
NSString *v_picturesDirectory();

#pragma mark -

/**
 *  生成唯一字符串
 *
 *  @return 唯一字符串
 */
NSString *v_uniqueIdentifier();

#pragma mark - 

/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
void v_callPhoneNumber(NSString *phoneNumber);

/**
 *  发送短信
 *
 *  @param phoneNumber 电话号码
 */
void v_sendSMSTo(NSString *phoneNumber);

/**
 *  打开浏览器
 *
 *  @param webURL 浏览网址
 */
void v_openBrowser(NSURL *webURL);

/**
 *  发送邮件
 *
 *  @param receiverEmail 收件人地址
 */
void v_emailTo(NSString *receiverEmail);

/**
 *  打开 App store
 *
 *  @param appLink App 地址
 */
void v_openAppStoreByAppLink(NSURL *appLink);

#pragma mark - 

/**
 *  清除徽标
 */
void v_clearApplicationIconBadge();

#pragma mark -

/**
 *  获取 TabBar 顶部那一条灰线
 *
 *  @param tabBar tabBar
 *
 *  @return 灰线
 */
UIView *v_hairLineForTabBar(UITabBar *tabBar);

/**
 *  获取导航栏底部的那一条灰线
 *
 *  @param navigationBar 导航栏
 *
 *  @return 灰线
 */
UIView *v_hairLineForNavigationBar(UINavigationBar *navigationBar);

#pragma mark -

/**
 *  异步获取图片
 *
 *  @param imageLink        图片地址链接
 *  @param ^completionBlock 获取到图片后回调
 *  @param ^errorBlock      获取图片失败回调
 */
void v_imageFromURL(NSURL *imageLink, void (^completionBlock)(UIImage *downloadedImage), void (^errorBlock)(NSError *error));

#pragma mark -

/**
 *  Swizzle
 *
 *  @param clazz            被替换的方法所属类
 *  @param originalSelector 原始方法
 *  @param overrideSelector 替换方法
 */
void v_methodSwizzle(Class clazz, SEL originalSelector, SEL overrideSelector);

#pragma mark - 

CGFloat v_minimumInteritemSpacingForCollection(CGFloat collectionViewWidth, CGFloat cellWidth, CGFloat horizontalCount);


@end


#pragma mark - Macros

#ifndef GettingStarted_CodeHelper_h
#define GettingStarted_CodeHelper_h

// Colors
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kWhiteColor [UIColor whiteColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]
#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]

// Fonts
#define kFontHeadLine [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]
#define kFontBody [UIFont preferredFontForTextStyle:UIFontTextStyleBody]
#define kFontSubheadline [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
#define kFontFootnote [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]
#define kFontCaption1 [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]
#define kFontCaption2 [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]

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
