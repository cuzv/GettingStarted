//
//  FourthViewController.m
//  GettingStarted
//
//  Created by Moch on 9/27/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "FourthViewController.h"
#import "ResizableTextView.h"
#import "TextConfigure.h"
#import "AFURLSessionManager.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "UIView+PercentageIndicatorView.h"

@implementation FourthViewController

- (void)viewDidLoad {
//    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.textView.layer.borderWidth = 1;
//    self.textView.didUpdateTextViewHeight = ^(ResizableTextView *textView) {
//        NSLog(@"current height = %f", textView.frame.size.height);
//    };
//
//    TextConfigure *textConfigure = [TextConfigure new];
//    textConfigure.countingLabel = self.countingLabel;
//    textConfigure.maximumLength = 100;
//    self.textView.textConfigure = textConfigure;
//    
//    MDRadialProgressTheme *newTheme = [[MDRadialProgressTheme alloc] init];
//    newTheme.completedColor = [UIColor colorWithRed:90/255.0 green:212/255.0 blue:39/255.0 alpha:1.0];
//    newTheme.incompletedColor = [UIColor colorWithRed:164/255.0 green:231/255.0 blue:134/255.0 alpha:1.0];
//    newTheme.centerColor = [UIColor clearColor];
//    newTheme.centerColor = [UIColor colorWithRed:224/255.0 green:248/255.0 blue:216/255.0 alpha:1.0];
//    newTheme.sliceDividerHidden = YES;
//    newTheme.labelColor = [UIColor blackColor];
//    newTheme.labelShadowColor = [UIColor whiteColor];
//    __block MDRadialProgressView *indicatorView = [[MDRadialProgressView alloc] initWithFrame:CGRectMake(20, 200, 40, 40) andTheme:newTheme];
//    [self.view addSubview:indicatorView];
    
//    NSURL *URL = [NSURL URLWithString:@"http://i.huffpost.com/gen/1641000/thumbs/o-GOT-MILK-570.jpg"];
//    [self.imageView sd_setImageWithURL:URL
//                      placeholderImage:nil
//                               options:SDWebImageRetryFailed
//                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                                  dispatch_async(dispatch_get_main_queue(), ^{
//                                      [indicatorView setProgress:((float)receivedSize / (float)expectedSize) animated:YES];
//                                  });
//                                  NSLog(@"%d / %d", receivedSize, expectedSize);
//                              } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                                  NSLog(@"ok");
//                              }];

//    
//    [self.imageView setImageWithURL:URL placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        NSLog(@"%d / %d", receivedSize, expectedSize);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            indicatorView.progressTotal = expectedSize;
//            indicatorView.progressCounter = receivedSize;
//        });
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"ok");
//    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    [self.navigationController.view addPercentageIndicatorView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
    [self.navigationController.view updatePercentage:0.45];
}

- (IBAction)remove:(id)sender {
    [self.navigationController.view removePercentageIndicatorView];
}


@end
