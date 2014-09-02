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

@property (weak, nonatomic) IBOutlet PaddingLabel *blurLabel;


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
    self.view.backgroundColor = [UIColor yellowColor];
//    [self.blurLabel blur];
//    self.blurLabel.text = @"dddd";
 
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}
- (IBAction)makeToast:(id)sender {

    
}

- (IBAction)makeAlert:(id)sender {
    
    [UIAlertView alertWithMessage:@"请检查网络设置请检查网络设置请检"];
}


@end
