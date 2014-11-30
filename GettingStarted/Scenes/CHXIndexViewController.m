//
//  IndexViewController.m
//  GettingStarted
//
//  Created by Moch Xiao on 11/18/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXIndexViewController.h"
#import "Extension.h"
#import "UIImageView+AFNetworking.h"
#import "CHXHTTPManager.h"

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) BOOL sex;
@end

@implementation Person

@end

@interface CHXIndexViewController () <UINavigationBarDelegate>

@property (nonatomic, strong) CHXBadgeView *badgeView;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation CHXIndexViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self testBadgeView];
	
	[self testTextConfigure];
}

- (void)testBadgeView {
	UIView *view1 = [[UIView alloc] init];
	view1.translatesAutoresizingMaskIntoConstraints = NO;
	view1.backgroundColor = [UIColor greenColor];
	[self.view addSubview:view1];
	
	UIView *superview = self.view;
	
	[superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[view1]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)]];
	[superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view1]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)]];

	[view1 chx_setBadgeValue:@"22"];
}

- (void)testTextConfigure {
	CHXTextEditConfigure *textconfigure = [CHXTextEditConfigure new];
	textconfigure.maximumLength = 5;
	[self.textField chx_setTextConfigure:textconfigure];
}

@end
