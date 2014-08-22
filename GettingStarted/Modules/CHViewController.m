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
#import "LocationPickerView.h"
#import "NSString+TextSize.h"

@interface CHViewController () <CHLocationPickerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectAddressButton;

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
    NSString *string = @"asdgldsagladslgjadsljglasdjlgsajglasdgldsagladslgjadsljglasdjlgsajglasdgldsagladslgjadsljglasdjlgsajglasdgldsagladslgjadsljglasdjlgsajgl";
    CGSize size = [string sizeWithFont:FontHeadLine width:300];
    
    NSLog(@"%@", NSStringFromCGSize(size));

//    NSDictionary *dict = @{@"cid":@"1001",
//                           @"oid":@"6611"};
//    [HttpManager setHttpRequestSerializerType:HttpRequestSerializerTypeBase64];
//    [HttpManager POSTWithMethodName:[NSString stringWithFormat:@"v4_%@.do", kMessageList] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
    // just for test Pod/ file is ignore success ?
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [UIView toastWithMessage:@"dddddddddddddddddddddddddddddddddddddddd" appearOrientation:CHToastAppearOrientationBottom];
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
        sleep(1.5);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}


- (IBAction)handleSelectAddress:(UIButton *)sender {
    LocationPickerView *locationPickerView = [[LocationPickerView alloc] initWithLocationPickerType:CHLocationPickerTypeCites selectedItem:^(NSString *item) {
        [self.selectAddressButton setTitle:item forState:UIControlStateNormal];
    }];
    [locationPickerView present];
}

//- (void)locationPickerView:(LocationPickerView *)locationPickerView didSelectItem:(NSString *)item {
//    [self.selectAddressButton setTitle:item forState:UIControlStateNormal];
//}


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
