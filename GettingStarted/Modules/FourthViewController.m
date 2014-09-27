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

@implementation FourthViewController

- (void)viewDidLoad {
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.updateTextViewHeight = ^(ResizableTextView *textView) {
        NSLog(@"current height = %f", textView.frame.size.height);
    };

    TextConfigure *textConfigure = [TextConfigure new];
    textConfigure.countingLabel = self.countingLabel;
    textConfigure.maximumLength = 100;
    self.textView.textConfigure = textConfigure;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
