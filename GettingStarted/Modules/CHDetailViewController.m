//
//  CHDetailViewController.m
//  GettingStarted
//
//  Created by Moch on 8/23/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CHDetailViewController.h"
#import "UIViewCategories.h"
#import "AccountManager.h"
#import "GradientCircularProgress.h"

#define kMessageList @"getMobileMessageList"

@interface CHDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutlet UIView *circleView;

@end

@implementation CHDetailViewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", self.colorView);
    
//    NSLog(@"%@", [self.colorView performSelector:@selector(recursiveDescription)]);
    for (UIView *subView in self.colorView.subviews) {
        if ([subView isKindOfClass:[GradientCircularProgress class]]) {
            NSLog(@"gotcha");
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

//    [self.navigationController.view addGradientCircularProgressAnimation];
//    [self.colorView addGradientCircularProgressAnimation];
//    NSLog(@"%@", [self.colorView performSelector:@selector(recursiveDescription)]);
    
    self.circleView.layer.masksToBounds = YES;
    self.circleView.layer.cornerRadius = CGRectGetMidY(self.circleView.bounds);

    [self.circleView addArcRotationAnimaionWithDuration:20 lineColor:[UIColor orangeColor]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.circleView removeArcRotationAnimation];
    
//    NSDictionary *dict = @{@"cid":@"1001",
//                           @"oid":@"6611"};
//    [HTTPManager setHTTPRequestSerializerType:HTTPRequestSerializerTypeBase64];
//    [HTTPManager requestWillBeginWithProgressAnimation];
//    [HTTPManager POSTWithMethodName:[NSString stringWithFormat:@"v4_%@.do", kMessageList] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];


//    [UIView toastWithMessage:@"密码错误"];
    
//    [self.colorView addActivityIndicatorAnimation];

//    [self.view addActivityIndicatorAnimationOnCenter:CGPointMake(10, 10)];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.colorView removeGradientCircularProgressAnimation];
}


- (IBAction)clearAction:(UIButton *)sender {
//    [self.colorView removeActivityIndicatorAnimation];
    [self.colorView removeGradientCircularProgressAnimation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
