//
//  CHXCodeHelper.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/19/14.
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

#import "CHXGlobalServices.h"
#import <UIKit/UIKit.h>
#import "UIAlertViewExtension.h"
#import <objc/runtime.h>

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

#pragma mark - Sandbox directory

NSString *__searchPathDirectory(NSSearchPathDirectory searchPathDirectory) {
	return [NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *chx_documentDirectory() {
	return __searchPathDirectory(NSDocumentDirectory);
}

NSString *chx_cachesDirectory() {
	return __searchPathDirectory(NSCachesDirectory);
}

NSString *chx_downloadsDirectory() {
	return __searchPathDirectory(NSDownloadsDirectory);
}

NSString *chx_moviesDirectory() {
	return __searchPathDirectory(NSMoviesDirectory);
}

NSString *chx_musicDirectory() {
	return __searchPathDirectory(NSMusicDirectory);
}

NSString *chx_picturesDirectory() {
	return __searchPathDirectory(NSPicturesDirectory);
}

#pragma mark - UniqueIdentifier

NSString *chx_uniqueIdentifier() {
	return [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

#pragma mark - Perform external jump

void __performApplicatonEventByURL(NSURL *eventURL) {
	UIApplication *application = [UIApplication sharedApplication];
	if ([application canOpenURL:eventURL]) {
		[application openURL:eventURL];
	} else {
		[UIAlertView chx_showAlertWithMessage:@"当前操作非法！"];
	}
}

void chx_callPhoneNumber(NSString *phoneNumber) {
	NSURL *destination = [NSURL URLWithString:[@"telprompt:" stringByAppendingString:phoneNumber]];
	__performApplicatonEventByURL(destination);
}

void chx_sendSMSTo(NSString *phoneNumber) {
	NSURL *destination = [NSURL URLWithString:[@"sms:" stringByAppendingString:phoneNumber]];
	__performApplicatonEventByURL(destination);
}

void chx_openBrowser(NSURL *webURL) {
	__performApplicatonEventByURL(webURL);
}

void chx_emailTo(NSString *receiverEmail) {
	NSURL *destination = [NSURL URLWithString:[@"mailto:" stringByAppendingString:receiverEmail]];
	__performApplicatonEventByURL(destination);
}

void chx_openAppStoreByAppLink(NSURL *appLink) {
	__performApplicatonEventByURL(appLink);
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

void chx_instanceMethodSwizzle(Class clazz, SEL originalSelector, SEL overrideSelector) {
	Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
	Method overrideMethod = class_getInstanceMethod(clazz, overrideSelector);
	
	method_exchangeImplementations(originalMethod, overrideMethod);
}

void chx_classMethodSwizzle(Class clazz, SEL originalSelector, SEL overrideSelector) {
	Method originalMethod = class_getClassMethod(clazz, originalSelector);
	Method overrideMethod = class_getClassMethod(clazz, overrideSelector);
	
	method_exchangeImplementations(originalMethod, overrideMethod);
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


