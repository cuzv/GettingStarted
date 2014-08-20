//
//  CHViewController.m
//  GettingStarted
//
//  Created by Moch on 8/17/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CHViewController.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"

@interface CHViewController ()

@end

@implementation CHViewController

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

    self.view.backgroundColor = [UIColor grayColor];
#define kMessageList @"getMobileMessageList"
    
    NSDictionary *dict = @{@"cid":@"1001",
                           @"oid":@"6611"};
    [HttpManager setHttpRequestSerializerType:HttpRequestSerializerTypeBase64];
    [HttpManager POSTWithMethodName:[NSString stringWithFormat:@"v4_%@.do", kMessageList] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView toastWithMessage:@"dddd" appearOrientation:CHToastAppearOrientationTop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showMessage:(NSString *)message
{
    [SVProgressHUD showWithStatus:message];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
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
