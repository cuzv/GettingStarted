//
//  BaseViewController.m
//  GettingStarted
//
//  Created by Moch Xiao on 8/23/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXBaseViewController.h"

@interface CHXBaseViewController ()

@end

@implementation CHXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    [self customBackBarButtonItem];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [HTTPManager removeLatelyRequest];
}

- (void)customBackBarButtonItem {
    UIBarButtonItem *backBarButtonItem = [UIBarButtonItem new];
    backBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backBarButtonItem;
    // if you wanna just display back indicator image as back button
    // go AppDelegate setting those code on `application:didFinishLaunchingWithOptions:`
    // UIImage *backImage = [UIImage imageNamed:@"navi_back"];
    // [[UINavigationBar appearance] setBackIndicatorImage:backImage];
    // [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImage];
}

@end
