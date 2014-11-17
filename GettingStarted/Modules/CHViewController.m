//
//  CHViewController.m
//  GettingStarted
//
//  Created by Moch on 8/17/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CHViewController.h"
#import "UIViewCategories.h"
#import "UIImageCategories.h"
#import "UIViewCategories.h"
#import "UIAlertViewCategories.h"
#import "UIButtonCategories.h"
#import "UITextFieldCategories.h"
#import "NSStringCategories.h"
#import "UINavigationBarCategories.h"


@interface CHViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) dispatch_source_t timer;
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
    
	// ••
	
	self.title = @"首页";
	
	

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
	
	if ([self.navigationController.navigationBar isInAnimation]) {
		[self.navigationController.navigationBar removeIndicatorAnimation];
	} else {
		[self.navigationController.navigationBar addIndicatorAnimation];
	}
}




@end
