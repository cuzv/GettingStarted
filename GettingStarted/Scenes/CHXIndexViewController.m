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
#import "CHXLoginHandler.h"
#import "AFNetworking.h"
#import "CHXBaseModel.h"

@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) BOOL sex;
@end

@implementation Person

@end


@interface UIImage (Swizzle)
+ (instancetype)swzzle_imageNamed:(NSString *)imageName;
@end

@implementation UIImage (Swizzle)

+ (instancetype)swzzle_imageNamed:(NSString *)imageName {
	NSLog(@"%@", imageName);
	return [self swzzle_imageNamed:imageName];
}

- (void)swzzle_initWithData:(NSData *)data {
	[self swzzle_initWithData:data];
}

@end

@interface CHXIndexViewController () <UINavigationBarDelegate>

@property (nonatomic, strong) CHXBadgeView *badgeView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation CHXIndexViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
//	[self testBadgeView];
//	
//	[self testTextConfigure];
//	
//	[self testSwizzle];
	
//	[self testBorder];
	
	
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

- (void)testSwizzle {
	chx_classMethodSwizzle([UIImage class], @selector(imageNamed:), @selector(swzzle_imageNamed:));

//	UIImage *image = [[UIImage alloc] initWithData:[NSData data]];
//	UIImage *image = [UIImage imageNamed:@"activity_gradient_gray"];
}

- (void)testBorder {
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 200, 80)];
	view.backgroundColor = [UIColor redColor];
	[self.view addSubview:view];

	[view chx_setBorderLineColor:[UIColor greenColor] edge:UIRectEdgeLeft];
//	[view chx_setBorderLineColor:[UIColor greenColor] edge:UIRectEdgeLeft | UIRectEdgeRight];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self testNetworking];
}

- (void)testNetworking {
	CHXLoginRequest *request = [[CHXLoginRequest alloc] initWithUsername:@"18583221776" password:@"123456"];
	[CHXLoginHandler handleRequest:request withSuccess:^(id modelObject) {
		NSLog(@"OK");
	} failure:^(id errorMessage) {
		NSLog(@"%@", errorMessage);
		NSLog(@"ERROR");
	}];
	
//	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//	manager.requestSerializer = [AFJSONRequestSerializer serializer];
//	manager.requestSerializer.timeoutInterval = 10;
//	[manager POST:@"http://10.128.8.250:8080/wfarm/customerLogin/json/1" parameters:@{@"uAccount":@"18583221776", @"uPass":@"123456"} success:^(NSURLSessionDataTask *task, id responseObject) {
//		NSLog(@"%@", responseObject);
//	} failure:^(NSURLSessionDataTask *task, NSError *error) {
//		NSLog(@"%@", error.localizedDescription);
//	}];
}

@end
