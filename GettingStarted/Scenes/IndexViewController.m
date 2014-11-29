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
#import "VHTTPManager.h"

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) BOOL sex;
@end

@implementation Person

@end

@interface IndexViewController () <UINavigationBarDelegate>

@property (nonatomic, strong) VBadgeView *badgeView;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation IndexViewController

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

	[view1 v_setBadgeValue:@"22"];
	
}

- (void)testTextConfigure {
	VTextEditConfigure *textconfigure = [VTextEditConfigure new];
	textconfigure.maximumLength = 5;
	[self.textField v_setTextConfigure:textconfigure];
}

@end
