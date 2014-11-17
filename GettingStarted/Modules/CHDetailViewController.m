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
#import "UINavigationBarCategories.h"

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
    
	[self.navigationController.navigationBar addIndicatorAnimation];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.navigationController.navigationBar removeIndicatorAnimation];
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
