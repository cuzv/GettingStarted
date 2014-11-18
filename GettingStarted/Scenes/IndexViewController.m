//
//  IndexViewController.m
//  GettingStarted
//
//  Created by Moch on 11/18/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "IndexViewController.h"
#import "Extension.h"

@implementation IndexViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.tabBarController.tabBarItem.badgeValue = @"1000";
	
	[self.view addSubview:({
		BadgeView *badgeView = [[BadgeView alloc] initWithOrigin:CGPointMake(2, self.view.height - 84) unreadNumber:1000];
		badgeView;
	})];
	
	[self.view addSubview:({
		BadgeView *badgeView = [[BadgeView alloc] initWithOrigin:CGPointMake(20, 188) unreadNumber:10];
		badgeView;
	})];
	
	[self.view addSubview:({
		BadgeView *badgeView = [[BadgeView alloc] initWithOrigin:CGPointMake(20, 288) unreadNumber:3];
		badgeView;
	})];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	
	if ([self.navigationController.navigationBar isInAnimation]) {
		[self.navigationController.navigationBar removeIndicatorAnimation];
	} else {
		[self.navigationController.navigationBar addIndicatorAnimation];
	}
}

@end
