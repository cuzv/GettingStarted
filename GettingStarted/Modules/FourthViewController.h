//
//  FourthViewController.h
//  GettingStarted
//
//  Created by Moch on 9/27/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "BaseViewController.h"
@class ResizableTextView;

@interface FourthViewController : BaseViewController

@property (weak, nonatomic) IBOutlet ResizableTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *countingLabel;

@end
