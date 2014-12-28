//
//  CHXIndexViewController.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-24.
//	Copyright (c) 2014 Moch Xiao (htt://github.com/atcuan).
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

#import "CHXIndexViewController.h"
#import "Extension.h"
#import "UIImageView+AFNetworking.h"
#import "CHXHTTPManager.h"
#import "CHXLoginHandler.h"
#import "AFNetworking.h"
#import "CHXBaseModel.h"
#import "NSStringExtension.h"
#import "CHXCodingableObject.h"
#import "CHXMacro.h"
#import "CHXDownloadRequest.h"

@interface Person : CHXCodingableObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) BOOL sex;

@end

@implementation Person

@end


@interface UIImage (Swizzle)
//+ (instancetype)swzzle_imageNamed:(NSString *)imageName;
@end

@implementation UIImage (Swizzle)

//+ (instancetype)swzzle_imageNamed:(NSString *)imageName {
//	NSLog(@"%@", imageName);
//	return [self swzzle_imageNamed:imageName];
//}
//
//- (void)swzzle_initWithData:(NSData *)data {
//	[self swzzle_initWithData:data];
//}

@end

@interface CHXIndexViewController () <UINavigationBarDelegate>

@property (nonatomic, strong) CHXBadgeView *badgeView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) UIView *view1;


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
		
//	[self testURLString];
	
//	[self testCoding];
	
//	[self testCodeLicenser];
	
//	[self testMethods];
	
//	[self testPrint];
	
}

- (void)testBadgeView {
	UIView *view1 = [[UIView alloc] init];
	view1.translatesAutoresizingMaskIntoConstraints = NO;
	view1.backgroundColor = [UIColor greenColor];
	[self.view addSubview:view1];
	
	UIView *superview = self.view;
	
	[superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[view1]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)]];
	[superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view1]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view1)]];

	[view1 chx_setBadgeValue:@"222"];
	self.view1 = view1;
	
	NSLog(@"self.view1 = %p", self.view1);
}

- (void)testTextConfigure {
	CHXTextEditConfigure *textconfigure = [CHXTextEditConfigure new];
	textconfigure.maximumLength = 5;
	[self.textField chx_setTextConfigure:textconfigure];
}

- (void)testSwizzle {
//	chx_classMethodSwizzle([UIImage class], @selector(imageNamed:), @selector(swzzle_imageNamed:));

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


- (void)testNetworking {
	CHXLoginRequest *request = [[CHXLoginRequest alloc] initWithUsername:@"18583221776" password:@"123456"];
	
	[CHXLoginHandler handleRequest:request withSuccess:^(id modelObject) {
		NSLog(@"modelObject = %@", modelObject);
	} failure:^(id errorMessage) {
		NSLog(@"errorMessage = %@", errorMessage);
//		NSURLErrorDomain
//		NSString *badge = [NSString stringWithFormat:@"%zd", arc4random() % 100];
//		NSLog(@"badge = %p", badge);
//		[self.view1 chx_setBadgeValue:badge];
	}];
//
//	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//	manager.requestSerializer = [AFJSONRequestSerializer serializer];
//	manager.requestSerializer.timeoutInterval = 10;
//	[manager POST:@"http://10.128.8.250:8081/wfarm/customerLogin/json/1" parameters:@{@"uAccount":@"18583221776", @"uPass":@"123456"} success:^(NSURLSessionDataTask *task, id responseObject) {
//		NSLog(@"%@", responseObject);
//		NSLog(@"%@", [responseObject objectForKey:@"rspMsg"]);
//	} failure:^(NSURLSessionDataTask *task, NSError *error) {
//		NSLog(@"%@", error.localizedDescription);
//	}];
}

- (void)testURLString {
	NSString *suffix = nil;

	NSString *baseString = @"http://www.baidu.com";
	baseString = [baseString stringByAppendingString:suffix];
	NSLog(@"%@", baseString);
}

- (void)testCoding {
	Person *person = [Person new];
	person.name = @"Lucy";
	person.age = 22;
	person.sex = NO;
	
	NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:person];
	NSLog(@"%@", encodedObject);
	[CHXUserDefaults setValue:encodedObject forKey:@"Person"];

	NSData *decodeObject = [CHXUserDefaults valueForKey:@"Person"];
	NSLog(@"%@", decodeObject);
	
	Person *newPerson = [NSKeyedUnarchiver unarchiveObjectWithData:decodeObject];
	NSLog(@"%@", [newPerson chx_toString]);
//
//	NSLog(@"%@", [CHXArchiver archivedValueForKey:@"Person"]);
}

- (void)testCodeLicenser {
	CHXCodeLicenser *licenser = [CHXCodeLicenser sharedInstance];
	NSString *filePath = @"/Users/Moch/Github/GettingStarted/GettingStarted";
	[licenser licenseCodeWithCreater:@"Moch Xiao" organization:@"Moch Xiao (htt://github.com/atcuan)" projectName:@"GettingStarted" filePath:filePath toLicenseType:CHXLicenseTypeMIT];
}

- (void)testMethods {
	for (NSString *name in [UIViewController chx_methods]) {
		NSLog(@"mthod: %@", name);
	}
}

- (void)testPrint {
	NSArray *array1 = @[@{@"小星星":@"都比"}, @{@"小星星":@"不做不会死"}];
//	NSLog(@"%@", array.description);
	NSDictionary *dict = @{@"key":@"哈哈", @"明知":@"罗霸道就跪了", @"dict":@{@"key":@"哈哈", @"明知":@"罗霸道就跪了"}};
	NSArray *array = @[
					   @"小米",
					   @"小花",
					   dict,
					   @[@"啦啦", @"哈哈"],
					   @"熊熊",
					   @[@"经历", @"哦额外", @"搭噶"],
					   array1
					   ];
	NSLog(@"%@", array);
	

//	NSLog(@"%@", dict);
	
//	NSArray *a1 = @[@"小米", @"吓死", @[@"啦啦", @"纠结"], @[@"技术", @"欧文", @"熬到"], @"奥迪"];
//	NSLog(@"%@", a1);
	
}

- (void)testDownload {
//	CHXDownloadRequest *reuest = [CHXDownloadRequest new];
//	[reuest startRequestWithSuccess:^(id responseData) {
//		NSLog(@"Ok");
//		UIImage *image = [[UIImage alloc] initWithContentsOfFile:reuest.downloadTargetFilePathString];
//		self.imageView.image = image;
//	} failue:^(id errorMessage) {
//		NSLog(@"%@", errorMessage);
//	}];
	
//	NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//	AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
//	// fileRemoteURL
//	NSString *fileRemoteURLString = @"http://ww3.sinaimg.cn/large/62580dd9gw1ennijqvvghj21300n5jts.jpg";
//	NSString *targetPathString = [chx_documentDirectory() stringByAppendingString:@"/sam.jpg"];
//	targetPathString = @"file:///Users/Moch/Desktop/sam.jpg";
//	NSURL *fileRemoteURL = [NSURL URLWithString:fileRemoteURLString];
//	NSURLRequest *downURLRequest = [NSURLRequest requestWithURL:fileRemoteURL];
//	NSURLSessionTask *dataTask = [sessionManager downloadTaskWithRequest:downURLRequest progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//		return [NSURL URLWithString:targetPathString];
//	} completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//		
//	}];
//	
//	[dataTask resume];
}

- (void)testAsynchronized {
	CHXLoginRequest *request = [[CHXLoginRequest alloc] initWithUsername:@"18583221776" password:@"123456"];
//	CHXLoginRequest *request2 = [[CHXLoginRequest alloc] initWithUsername:@"18583221776" password:@"123456"];
	
//	if ([request isEqual:request2]) {
//		NSLog(@"ok");
//	}
	
	[request startRequest];
	[request successCompletionResponse:^(id responseData) {
		NSLog(@"11111%@", responseData);
	}];
	
	
//
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		[request successCompletionResponse:^(id responseData) {
//			NSLog(@"2222%@", responseData);
//		}];
//	});
	
	
//	[request startRequestWithSuccess:^(id responseData) {
//		NSLog(@"ddd");
//	} failue:^(id errorMessage) {
//		NSLog(@"jjjj");
//	}];

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	[self testNetworking];
//	[self testDownload];
	
	[self testAsynchronized];
}



@end
