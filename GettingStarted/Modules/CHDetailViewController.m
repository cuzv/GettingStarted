//
//  CHDetailViewController.m
//  GettingStarted
//
//  Created by Moch on 8/23/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CHDetailViewController.h"
#import "UIView+UIActivityIndicatorView.h"

#define kMessageList @"getMobileMessageList"

@interface CHDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end

@implementation CHDetailViewController

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
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSDictionary *dict = @{@"cid":@"1001",
//                           @"oid":@"6611"};
//    [HTTPManager setHTTPRequestSerializerType:HTTPRequestSerializerTypeBase64];
//    [HTTPManager requestWillBeginWithProgressAnimation];
//    [HTTPManager POSTWithMethodName:[NSString stringWithFormat:@"v4_%@.do", kMessageList] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//    

    [UIView toastWithMessage:@"用户名错误"];
    
//    [self.colorView addActivityIndicatorAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)clearAction:(UIButton *)sender {
    [self.colorView removeActivityIndicatorAnimation];
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
