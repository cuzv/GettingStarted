//
//  CHViewController.m
//  GettingStarted
//
//  Created by Moch on 8/17/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CHViewController.h"
#import "UIView+Toast.h"
#import "LocationPickerView.h"
#import "NSString+TextSize.h"
#import "UIView+Animation.h"
#import "LoadingView.h"

@interface CHViewController () <CHLocationPickerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectAddressButton;
@property (weak, nonatomic) IBOutlet UIButton *circleButton;

@property (nonatomic, strong) LoadingView *loadingView;


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
//    self.selectAddressButton.backgroundColor = [UIColor colorWithRGBA:@[@245, @232, @8, @1]];
//    CHRGBColor(245, 232, 8, 1);
    
    self.circleButton.layer.cornerRadius = 44;
    self.circleButton.layer.masksToBounds = YES;
    
    _loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(100, 200, 40, 70)];
    _loadingView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_loadingView];
    [_loadingView startAnimation];

    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [UIView toastWithMessage:@"用户名错误"];
//    [self loadingAnimation];
    [_loadingView stopAnimation];
}

- (IBAction)handleSelectAddress:(UIButton *)sender {
//    LocationPickerView *locationPickerView = [[LocationPickerView alloc] initWithLocationPickerType:CHLocationPickerTypeCites selectedItem:^(NSString *item) {
//        [self.selectAddressButton setTitle:item forState:UIControlStateNormal];
//    }];
//    [locationPickerView showInView:self.view];
//    [self.view removeLoadingAnimation];
}

- (void)loadingAnimation {
    [self.view addLoadingAnimation];
}

@end
