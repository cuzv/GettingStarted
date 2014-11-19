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
	
//	[self testBadgeView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	
	if ([self.navigationController.navigationBar isInAnimation]) {
		[self.navigationController.navigationBar removeIndicatorAnimation];
	} else {
		[self.navigationController.navigationBar addIndicatorAnimation];
	}
	


}

- (void)testBadgeView {
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
	
	[self.view addSubview:({
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40, 250, 30, 30)];
		[button setTitle:@"" forState:UIControlStateNormal];
		UIImage *image = [UIImage imageWithColor:[UIColor redColor] size:button.size ];
		[button setBackgroundImage:image forState:UIControlStateNormal];
		
		[button addArcRotationAnimaionWithDuration:5 lineColor:[UIColor greenColor]];
		button;
	})];
	
	NSString *email = @"atcuan@gmail.com";
	NSLog(@"%@", [email isValidEmail] ? @" YES" : @"NO");
	
	NSLog(@"%@", uniqueIdentifier());
	
	[UIAlertView showAlertWithMessage:@"消息来了"];
}

@end
