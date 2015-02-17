//
//  CHXGlobalServices.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-05.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CHXGlobalServices.h"
#import <UIKit/UIKit.h>
#import "UIAlertViewExtension.h"
#import <objc/runtime.h>
#include <sys/dirent.h>
#include <sys/stat.h>

@implementation CHXGlobalServices

#pragma mark - System infos

NSUInteger chx_deviceSystemMajorVersion() {
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

float chx_appBuildNumber() {
    static float _appBuild;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appBuild = [[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"] floatValue];
    });
    
    return _appBuild;
}

float chx_appVersionNumber() {
    static float _appVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appVersion = [[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] floatValue];
    });
    
    return _appVersion;
}

#pragma mark - Device Screen

CGRect chx_screenBounds() {
    static CGRect _screenBounds;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _screenBounds = [UIScreen mainScreen].bounds;
    });
    return _screenBounds;
}

CGFloat chx_screenWidth() {
    return chx_screenBounds().size.width;
}

CGFloat chx_screenHeight() {
    return chx_screenBounds().size.height;
}

#pragma mark - Angle & Radian

CGFloat chx_radianFromAngle(CGFloat angle) {
    return M_PI * angle / 180.0f;
}

CGFloat chx_angleFromRadian(CGFloat radian) {
    return M_PI * 180.0f / radian;
}

#pragma mark - Sandbox

NSString *pr_searchPathDirectory(NSSearchPathDirectory searchPathDirectory) {
    return [NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *chx_documentDirectory() {
    return pr_searchPathDirectory(NSDocumentDirectory);
}

NSString *chx_cachesDirectory() {
    return pr_searchPathDirectory(NSCachesDirectory);
}

NSString *chx_downloadsDirectory() {
    return pr_searchPathDirectory(NSDownloadsDirectory);
}

NSString *chx_moviesDirectory() {
    return pr_searchPathDirectory(NSMoviesDirectory);
}

NSString *chx_musicDirectory() {
    return pr_searchPathDirectory(NSMusicDirectory);
}

NSString *chx_picturesDirectory() {
    return pr_searchPathDirectory(NSPicturesDirectory);
}

long long pr_folderSizeAtPath(const char *folderPath) {
    long long folderSize = 0;
    DIR *dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    
    while (NULL != (child = readdir(dir))) {
        //		bool hidden = (child->d_name[0] == '.' && child->d_name[1] == 0); // 忽略目录 .
        //		bool uplevel = (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0); // 忽略目录 ..
        //		if (child->d_type == DT_DIR && (hidden || uplevel)) {
        //			continue;
        //		}
        if (child->d_type == DT_DIR) {
            continue;
        }
        
        UInt8 folderPathLength = strlen(folderPath);
        // 子文件的路径地址
        char childPath[1024];
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength - 1] != '/') {
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR) {
            // directory
            // 递归调用子目录
            folderSize += pr_folderSizeAtPath(childPath);
            // 把目录本身所占的空间也加上
            struct stat st;
            if (0 == lstat(childPath, &st)) {
                folderSize += st.st_size;
            }
        } else if (child->d_type == DT_REG || child->d_type == DT_LNK) {
            // file or link
            struct stat st;
            if (0 == lstat(childPath, &st)) {
                folderSize += st.st_size;
            }
        }
    }
    
    return folderSize;
}

long long chx_folderSizeAtPath(NSString *folderPath) {
    return pr_folderSizeAtPath([folderPath cStringUsingEncoding:NSUTF8StringEncoding]);
}

#pragma mark - UniqueIdentifier

NSString *chx_uniqueIdentifier() {
    return [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

#pragma mark - Perform external jump

void pr_performApplicatonEventByURL(NSURL *eventURL) {
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:eventURL]) {
        [application openURL:eventURL];
    } else {
        [UIAlertView chx_showAlertWithMessage:@"当前操作非法！"];
    }
}

void chx_callPhoneNumber(NSString *phoneNumber) {
    NSURL *destination = [NSURL URLWithString:[@"telprompt:" stringByAppendingString:phoneNumber]];
    pr_performApplicatonEventByURL(destination);
}

void chx_sendSMSTo(NSString *phoneNumber) {
    NSURL *destination = [NSURL URLWithString:[@"sms:" stringByAppendingString:phoneNumber]];
    pr_performApplicatonEventByURL(destination);
}

void chx_openBrowser(NSURL *webURL) {
    pr_performApplicatonEventByURL(webURL);
}

void chx_emailTo(NSString *receiverEmail) {
    NSURL *destination = [NSURL URLWithString:[@"mailto:" stringByAppendingString:receiverEmail]];
    pr_performApplicatonEventByURL(destination);
}

void chx_openAppStoreByAppLink(NSURL *appLink) {
    pr_performApplicatonEventByURL(appLink);
}

#pragma mark - Clear badge

void chx_clearApplicationIconBadge() {
    UIApplication *application = [UIApplication sharedApplication];
    NSInteger badgeNumber = application.applicationIconBadgeNumber;
    application.applicationIconBadgeNumber = 1;
    application.applicationIconBadgeNumber = 0;
    [application cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = badgeNumber;
}

#pragma mark - Hairline for bar

UIView *chx_hairLineForTabBar(UITabBar *tabBar) {
    Class imageViewClass = [UIImageView class];
    for (UIView *view in tabBar.subviews) {
        if ([view isKindOfClass:imageViewClass] &&
            view.frame.size.height == 0.5f) {
            return view;
        }
    }
    
    return nil;
}

UIView *chx_hairLineForNavigationBar(UINavigationBar *navigationBar) {
    Class navigationBarBackgroundClass = NSClassFromString(@"_UINavigationBarBackground");
    for (UIView *view in navigationBar.subviews) {
        if ([view isKindOfClass:navigationBarBackgroundClass]) {
            Class imageViewClass = [UIImageView class];
            for (UIView *subView in view.subviews) {
                if ([subView isKindOfClass:imageViewClass] &&
                    subView.frame.size.height == 0.5f) {
                    return subView;
                }
            }
        }
    }
    
    return nil;
}

#pragma mark - Asynchronization get image

void chx_imageFromURL(NSURL *imageLink, void (^completionBlock)(UIImage *downloadedImage), void (^errorBlock)(NSError *error)) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageLink options:NSDataReadingMappedIfSafe error:&error];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                errorBlock(error);
            });
        } else {
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    completionBlock(image);
                } else {
                    errorBlock(nil);
                }
            });
        }
    });
}

#pragma mark - Swizzle

// 该方法应该在 dispatch_once 中执行
void chx_swizzleInstanceMethod(Class clazz, SEL originalSelector, SEL overrideSelector) {
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    Method overrideMethod = class_getInstanceMethod(clazz, overrideSelector);
    
    if (class_addMethod(clazz, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(clazz, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}

// 该方法应该在 dispatch_once 中执行
void chx_swizzleClassMethod(Class clazz, SEL originalSelector, SEL overrideSelector) {
    Method originalMethod = class_getClassMethod(clazz, originalSelector);
    Method overrideMethod = class_getClassMethod(clazz, overrideSelector);
    
    if (class_addMethod(clazz, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(clazz, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}

#pragma mark - Collection spacing

CGFloat chx_minimumInteritemSpacingForCollection(CGFloat collectionViewWidth, CGFloat cellWidth, CGFloat horizontalCount) {
    return (collectionViewWidth - cellWidth * horizontalCount) / (horizontalCount + 1);
}

#pragma mark - Autolayout helpers

void chx_leftAlignAndVerticallySpaceOutViews(NSArray *views, CGFloat distance) {
    for (NSUInteger i = 1; i < views.count; i++) {
        UIView *firstView = views[i - 1];
        UIView *secondView = views[i];
        
        [firstView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [secondView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:firstView
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:secondView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:distance];
        
        NSLayoutConstraint *leadingConstraint =  [NSLayoutConstraint constraintWithItem:firstView
                                                                              attribute:NSLayoutAttributeLeading
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:secondView
                                                                              attribute:NSLayoutAttributeLeading
                                                                             multiplier:1
                                                                               constant:0];
        
        [firstView.superview addConstraints:@[verticalConstraint, leadingConstraint]];
    }
}


@end

#pragma mark - 斜切变换

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y) {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}