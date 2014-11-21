//
//  IndexViewController.m
//  GettingStarted
//
//  Created by Moch on 11/18/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "IndexViewController.h"
#import "Extension.h"
#import "UIImageView+AFNetworking.h"


@interface IndexViewController () <UINavigationBarDelegate>

@end

@implementation IndexViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
//	[self testBadgeView];
	
//	NSLog(@"%f", appVersion());
	
//	NSInteger integer = 1;
//	NSLog(@"first number: %zd", integer);
//	
//	NSUInteger uinteger = 1;
//	NSLog(@"second number: %tu", uinteger);
//	UINavigationBar *customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
//	customNavigationBar.delegate = self;
//	[self.view addSubview:customNavigationBar];
//
//	
//	hairLineForNavigationBar(self.navigationController.navigationBar).hidden = YES;
	
//	NSURL *imageLink = [NSURL URLWithString:@"http://cdn.tutsplus.com/mobile/uploads/2014/01/5a3f1-sample.jpg"];
//	imageFromURL(imageLink, ^(UIImage *downloadedImage) {
//		NSLog(@"%@", downloadedImage);
//	}, ^(NSError *error) {
//		NSLog(@"%@", [error localizedDescription]);
//	});
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	
//	if ([self.navigationController.navigationBar isInAnimation]) {
//		[self.navigationController.navigationBar removeIndicatorAnimation];
//	} else {
//		[self.navigationController.navigationBar addIndicatorAnimation];
//	}
	
//	[self testNavi];
//	openBrowser([NSURL URLWithString:@"http://www.baidu.com"]);
//	emailTo(@"atcuan@gmail.com");
//	sendSMSTo(@"18583221776");
	
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

- (void)testNavi {
	if (self.isNavigationActivityIndicatorViewInAnimation) {
		[self removeNavigationBarRightItemActivityIndicatorAnimation];
	} else {
		[self addNavigationBarRightItemActivityIndicatorAnimation];
	}
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
	return UIBarPositionTopAttached;
}

@end
