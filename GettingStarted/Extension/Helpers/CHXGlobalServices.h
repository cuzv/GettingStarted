//
//  CHXGlobalServices.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-19.
//	Copyright (c) 2014 Moch Xiao (htt://github.com/atcuan).
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

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@class UIView, UINavigationBar, UITabBar, UIImage, NSError;

@interface CHXGlobalServices : NSObject

#pragma mark - System infos

/**
 *  获取设备系统版本号，Apple code
 *
 *  @return 设备系统版本号
 */
NSUInteger chx_deviceSystemMajorVersion();

/**
 *  获取 App build number
 *
 *  @return App build number
 */
float chx_appBuildNumber();

/**
 *  获取 App 版本号
 *
 *  @return App 版本号
 */
float chx_appVersionNumber();

#pragma mark - Device Screen

/**
 *  获取设备屏幕dounds
 *
 *  @return 设备屏幕dounds
 */
struct CGRect chx_screenBounds();

/**
 *  获取屏幕宽度
 *
 *  @return 屏幕宽度
 */
CGFloat chx_screenWidth();

/**
 *  获取屏幕高度
 *
 *  @return 屏幕高度
 */
CGFloat chx_screenHeight();

#pragma mark - Angle & Radian

/**
 *  角度转弧度
 *
 *  @param angle 角度值
 *
 *  @return 弧度值
 */
CGFloat chx_radianFromAngle(CGFloat angle);

/**
 *  弧度转角度
 *
 *  @param radian 弧度
 *
 *  @return 角度
 */
CGFloat chx_angleFromRadian(CGFloat radian);

#pragma mark - Sandbox directory

/**
 *  获取沙盒文档目录
 *
 *  @return 沙盒文档目录
 */
NSString *chx_documentDirectory();

/**
 *  获取沙盒缓存目录
 *
 *  @return 沙盒缓存目录
 */
NSString *chx_cachesDirectory();

/**
 *  获取沙盒下载目录
 *
 *  @return 沙盒下载目录
 */
NSString *chx_downloadsDirectory();

/**
 *  获取沙盒电影目录
 *
 *  @return 沙盒电影目录
 */
NSString *chx_moviesDirectory();

/**
 *  获取沙盒音乐目录
 *
 *  @return 沙盒音乐目录
 */
NSString *chx_musicDirectory();

/**
 *  获取沙盒图片目录
 *
 *  @return 沙盒图片目录
 */
NSString *chx_picturesDirectory();

#pragma mark - UniqueIdentifier

/**
 *  生成唯一字符串
 *
 *  @return 唯一字符串
 */
NSString *chx_uniqueIdentifier();

#pragma mark - Perform external jump

/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
void chx_callPhoneNumber(NSString *phoneNumber);

/**
 *  发送短信
 *
 *  @param phoneNumber 电话号码
 */
void chx_sendSMSTo(NSString *phoneNumber);

/**
 *  打开浏览器
 *
 *  @param webURL 浏览网址
 */
void chx_openBrowser(NSURL *webURL);

/**
 *  发送邮件
 *
 *  @param receiverEmail 收件人地址
 */
void chx_emailTo(NSString *receiverEmail);

/**
 *  打开 App store
 *
 *  @param appLink App 地址
 */
void chx_openAppStoreByAppLink(NSURL *appLink);

#pragma mark - Clear badge

/**
 *  清除徽标
 */
void chx_clearApplicationIconBadge();

#pragma mark - Hairline for bar

/**
 *  获取 TabBar 顶部那一条灰线
 *
 *  @param tabBar tabBar
 *
 *  @return 灰线
 */
UIView *chx_hairLineForTabBar(UITabBar *tabBar);

/**
 *  获取导航栏底部的那一条灰线
 *
 *  @param navigationBar 导航栏
 *
 *  @return 灰线
 */
UIView *chx_hairLineForNavigationBar(UINavigationBar *navigationBar);

#pragma mark - Asynchronization get image

/**
 *  异步获取图片
 *
 *  @param imageLink        图片地址链接
 *  @param ^completionBlock 获取到图片后回调
 *  @param ^errorBlock      获取图片失败回调
 */
void chx_imageFromURL(NSURL *imageLink, void (^completionBlock)(UIImage *downloadedImage), void (^errorBlock)(NSError *error));

#pragma mark - Swizzle

/**
 *  Swizzle 实例方法
 *
 *  @param clazz            被替换的方法所属类
 *  @param originalSelector 原始方法
 *  @param overrideSelector 替换方法
 */
void chx_instanceMethodSwizzle(Class clazz, SEL originalSelector, SEL overrideSelector);

/**
 *  Swizzle 类方法
 *
 *  @param clazz            被替换的方法所属类
 *  @param originalSelector 原始方法
 *  @param overrideSelector 替换方法
 */
void chx_classMethodSwizzle(Class clazz, SEL originalSelector, SEL overrideSelector);

#pragma mark - Collection spacing

CGFloat chx_minimumInteritemSpacingForCollection(CGFloat collectionViewWidth, CGFloat cellWidth, CGFloat horizontalCount);

#pragma mark - Autolayout helpers

/**
 *  添加左对齐约束
 *
 *  @param views    需要左对齐的视图
 *  @param distance 垂直距离
 */
void chx_leftAlignAndVerticallySpaceOutViews(NSArray *views, CGFloat distance);

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

//  A better version of NSLog
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
