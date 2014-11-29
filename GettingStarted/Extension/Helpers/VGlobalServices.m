//
//  CodeHelper.m
//  GettingStarted
//
//  Created by Moch on 11/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "VGlobalServices.h"
#import <UIKit/UIKit.h>
#import "UIAlertViewExtension.h"
#import <objc/runtime.h>

@implementation VGlobalServices

#pragma mark -

NSUInteger v_deviceSystemMajorVersion() {
	static NSUInteger _deviceSystemMajorVersion = -1;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
	});
	return _deviceSystemMajorVersion;
}

float v_appBuildNumber() {
	static float _appBuild;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_appBuild = [[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"] floatValue];
	});
	
	return _appBuild;
}

float v_appVersionNumber() {
	static float _appVersion;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_appVersion = [[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] floatValue];
	});
	
	return _appVersion;
}

#pragma mark -

CGRect v_screenBounds() {
	static CGRect _screenBounds;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_screenBounds = [UIScreen mainScreen].bounds;
	});
	return _screenBounds;
}

CGFloat v_screenWidth() {
	return v_screenBounds().size.width;
}

CGFloat v_screenHeight() {
	return v_screenBounds().size.height;
}

#pragma mark -

CGFloat v_radianFromAngle(CGFloat angle) {
	return M_PI * angle / 180.0f;
}

CGFloat v_angleFromRadian(CGFloat radian) {
	return M_PI * 180.0f / radian;
}

#pragma mark -

NSString *v_searchPathDirectory(NSSearchPathDirectory searchPathDirectory) {
	return [NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *v_documentDirectory() {
	return v_searchPathDirectory(NSDocumentDirectory);
}

NSString *v_cachesDirectory() {
	return v_searchPathDirectory(NSCachesDirectory);
}

NSString *v_downloadsDirectory() {
	return v_searchPathDirectory(NSDownloadsDirectory);
}

NSString *v_moviesDirectory() {
	return v_searchPathDirectory(NSMoviesDirectory);
}

NSString *v_musicDirectory() {
	return v_searchPathDirectory(NSMusicDirectory);
}

NSString *v_picturesDirectory() {
	return v_searchPathDirectory(NSPicturesDirectory);
}

#pragma mark - 

NSString *v_uniqueIdentifier() {
	return [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

#pragma mark - 

void performApplicatonEventByURL(NSURL *eventURL) {
	UIApplication *application = [UIApplication sharedApplication];
	if ([application canOpenURL:eventURL]) {
		[application openURL:eventURL];
	} else {
		[UIAlertView v_showAlertWithMessage:@"当前操作非法！"];
	}
}

void v_callPhoneNumber(NSString *phoneNumber) {
	NSURL *destination = [NSURL URLWithString:[@"telprompt:" stringByAppendingString:phoneNumber]];
	performApplicatonEventByURL(destination);
}

void v_sendSMSTo(NSString *phoneNumber) {
	NSURL *destination = [NSURL URLWithString:[@"sms:" stringByAppendingString:phoneNumber]];
	performApplicatonEventByURL(destination);
}

void v_openBrowser(NSURL *webURL) {
	performApplicatonEventByURL(webURL);
}

void v_emailTo(NSString *receiverEmail) {
	NSURL *destination = [NSURL URLWithString:[@"mailto:" stringByAppendingString:receiverEmail]];
	performApplicatonEventByURL(destination);
}

void v_openAppStoreByAppLink(NSURL *appLink) {
	performApplicatonEventByURL(appLink);
}

#pragma mark - 

void v_clearApplicationIconBadge() {
	UIApplication *application = [UIApplication sharedApplication];
	NSInteger badgeNumber = application.applicationIconBadgeNumber;
	application.applicationIconBadgeNumber = 1;
	application.applicationIconBadgeNumber = 0;
	[application cancelAllLocalNotifications];
	application.applicationIconBadgeNumber = badgeNumber;
}

#pragma mark -

UIView *v_hairLineForTabBar(UITabBar *tabBar) {
	Class imageViewClass = [UIImageView class];
	for (UIView *view in tabBar.subviews) {
		if ([view isKindOfClass:imageViewClass] &&
			view.frame.size.height == 0.5f) {
			return view;
		}
	}

	return nil;
}

UIView *v_hairLineForNavigationBar(UINavigationBar *navigationBar) {
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

#pragma mark -

void v_imageFromURL(NSURL *imageLink, void (^completionBlock)(UIImage *downloadedImage), void (^errorBlock)(NSError *error)) {
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

#pragma mark -

void v_methodSwizzle(Class clazz, SEL originalSelector, SEL overrideSelector) {
	Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
	Method overrideMethod = class_getInstanceMethod(clazz, overrideSelector);
	
	BOOL addMethodSuccess = class_addMethod(clazz,
											originalSelector,
											method_getImplementation(overrideMethod),
											method_getTypeEncoding(overrideMethod));
	if (addMethodSuccess) {
		class_replaceMethod(clazz,
							overrideSelector,
							method_getImplementation(originalMethod),
							method_getTypeEncoding(originalMethod));
	} else {
		method_exchangeImplementations(originalMethod, overrideMethod);
	}
}

#pragma mark -

CGFloat v_minimumInteritemSpacingForCollection(CGFloat collectionViewWidth, CGFloat cellWidth, CGFloat horizontalCount) {
	return (collectionViewWidth - cellWidth * horizontalCount) / (horizontalCount + 1);
}

#pragma mark -

@end


