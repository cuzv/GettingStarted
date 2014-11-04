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
#import "UIViewControllerCategories.h"
#import "UIImageCategories.h"
#import "UIButtonCategories.h"
#import "GapRing.h"

#define kMessageList @"getMobileMessageList"

@interface CHDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutlet UIView *circleView;

@property (nonatomic, strong) UIButton *button;
@property (strong, nonatomic) GapRing *gapRing;

@end

@implementation CHDetailViewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"导航栏";
    
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor]};
    
    NSLog(@"%@", self.title);
    NSLog(@"%@", self.navigationItem.title);
    
    self.navigationItem.titleView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        view.backgroundColor = [UIColor orangeColor];
        view;
    });
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(20, 180, 80, 30)];
    [_button addTarget:self action:@selector(handleSendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_button setTitle:@"点我呀" forState:UIControlStateNormal];
    [_button setTitle:@"哦哦" forState:UIControlStateHighlighted];
    
    _button.backgroundColor = [UIColor purpleColor];
    
//    UIImage *image = [UIImage imageWithColor:[UIColor redColor] size:_button.size];
//    [_button setBackgroundImage:image forState:UIControlStateNormal];

    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 5;
    _button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _button.layer.borderWidth = 1;

    
    [self.view addSubview:_button];
    
    
    self.gapRing = [[GapRing alloc] initWithFrame:CGRectMake(20, 260, 40, 40)];
    [self.view addSubview:_gapRing];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self addNavigationBarActivityIndicatorAnimation];
//    [self addNavigationBarRightItemActivityIndicatorAnimation];
    [self.view addGradientCircularProgressAnimation];
}

- (IBAction)stop:(UIButton *)sender {
//    [self removeNavigationBarActivityIndicatorAnimation];
//    [self removeNavigationBarRightItemActivityIndicatorAnimation];
//    [_button removeWaitingAnimation];
    
//    [self.view removeGradientCircularProgressAnimation];
    
    if (self.gapRing.isAnimating) {
        [self.gapRing stopAnimation];
    } else {
        [self.gapRing startAnimation];
    }
}

- (void)handleSendAction:(UIButton *)sender {
    [sender addWaitingAnimation];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [self removeNavigationBarActivityIndicatorAnimation];
//    [self removeNavigationBarRightItemActivityIndicatorAnimation];
}


@end
