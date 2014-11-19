//
//  CodeHelper.m
//  GettingStarted
//
//  Created by Moch on 11/19/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CodeHelper.h"
#import <UIKit/UIKit.h>

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

@end


