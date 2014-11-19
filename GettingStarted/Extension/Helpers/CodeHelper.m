//
//  CodeHelper.m
//  GettingStarted
//
//  Created by Moch on 11/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CodeHelper.h"
#import <UIKit/UIKit.h>
#import "UIAlertViewExtension.h"

@implementation CodeHelper

#pragma mark -

NSUInteger deviceSystemMajorVersion() {
	static NSUInteger _deviceSystemMajorVersion = -1;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
	});
	return _deviceSystemMajorVersion;
}

float appBuild() {
	static float _appBuild;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_appBuild = [[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"] floatValue];
	});
	
	return _appBuild;
}

float appVersion() {
	static float _appVersion;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_appVersion = [[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] floatValue];
	});
	
	return _appVersion;
}

#pragma mark -

CGRect screenBounds() {
	static CGRect _screenBounds;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_screenBounds = [UIScreen mainScreen].bounds;
	});
	return _screenBounds;
}

CGFloat screenWidth() {
	return screenBounds().size.width;
}

CGFloat screenHeight() {
	return screenBounds().size.height;
}

#pragma mark -

CGFloat radianFromAngle(CGFloat angle) {
	return M_PI * angle / 180.0f;
}

CGFloat angleFromRadian(CGFloat radian) {
	return M_PI * 180.0f / radian;
}

#pragma mark -

NSString *documentDirectory() {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *cachesDirectory() {
	return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *downloadsDirectory() {
	return [NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *moviesDirectory() {
	return [NSSearchPathForDirectoriesInDomains(NSMoviesDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *musicDirectory() {
	return [NSSearchPathForDirectoriesInDomains(NSMusicDirectory, NSUserDomainMask, YES) firstObject];
}

NSString *picturesDirectory() {
	return [NSSearchPathForDirectoriesInDomains(NSPicturesDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark - 

NSString *uniqueIdentifier() {
	return [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

#pragma mark - 

void performApplicatonEventByURL(NSURL *eventURL) {
	UIApplication *application = [UIApplication sharedApplication];
	if ([application canOpenURL:eventURL]) {
		[application openURL:eventURL];
	} else {
		[UIAlertView showAlertWithMessage:@"当前操作非法！"];
	}
}

void callPhoneNumber(NSString *phoneNumber) {
	NSURL *destination = [NSURL URLWithString:[@"telprompt:" stringByAppendingString:phoneNumber]];
	performApplicatonEventByURL(destination);
}

void sendSMSTo(NSString *phoneNumber) {
	NSURL *destination = [NSURL URLWithString:[@"sms:" stringByAppendingString:phoneNumber]];
	performApplicatonEventByURL(destination);
}

void openBrowser(NSURL *webURL) {
	performApplicatonEventByURL(webURL);
}

void emailTo(NSString *receiverEmail) {
	NSURL *destination = [NSURL URLWithString:[@"mailto:" stringByAppendingString:receiverEmail]];
	performApplicatonEventByURL(destination);
}

void openAppStoreByAppLink(NSURL *appLink) {
	performApplicatonEventByURL(appLink);
}

@end


