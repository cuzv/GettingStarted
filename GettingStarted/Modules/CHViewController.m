//
//  CHViewController.m
//  GettingStarted
//
//  Created by Moch on 8/17/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CHViewController.h"
#import "PaddingLabel.h"
#import "UIView+Toast.h"


@interface CHViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(240, 128)];
    self.imageView.image = image;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [UIAlertView alertWithAutomaticDisappearMessage:@"密码错误"];
}


- (IBAction)makeToast:(id)sender {
//    [self.view makeToast:@"密码错误"];
//    [self.view makeToast:@"请检查网络设置请检查网络设置请检查网络请检查网络设置请检查网络设置请检查网络设置请检查网络设置"];
}

- (IBAction)makeAlert:(id)sender {
    [UIAlertView alertWithMessage:@"请检查网络设置请检查网络设置请检"];
}

- (IBAction)handleHUD:(id)sender {
//    [self.view showHUDWithMessage:@"用户名错误"];
//    [self.view showLoadingHUD];
//    [self.navigationController.view showLoadingHUDWithMessage:nil];
//    [self.view showLoadingHUD];
//    [self.view testUploadingHUD];
//    [self.view testDownloadingHUD];
//    [self.navigationController.view showDownloadingHUD];
//    [self.view showSuccessHUDWithMessage:@"成功"];
//    [self.view showFailureHUDWithMessage:nil];
    
//    [self.view showCancelableHUDWithMessage:@"信息加载中..." cancelConfirmMessage:@"确定"];
    
    [self.view addActivityIndicatorAnimation];
    
}


- (IBAction)dismiss:(id)sender {
//    [self.view dismissHUD];
    [self.view removeActivityIndicatorAnimation];
}


- (IBAction)archive:(id)sender {
}

- (IBAction)unarchive:(id)sender {
}







@end
