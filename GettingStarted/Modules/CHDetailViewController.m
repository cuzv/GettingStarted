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

#define kMessageList @"getMobileMessageList"

@interface CHDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (strong, nonatomic) IBOutlet UIView *circleView;

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
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self addNavigationBarActivityIndicatorAnimation];
    [self addNavigationBarRightItemActivityIndicatorAnimation];
}

- (IBAction)stop:(id)sender {
    [self removeNavigationBarActivityIndicatorAnimation];
    [self removeNavigationBarRightItemActivityIndicatorAnimation];
}



@end
