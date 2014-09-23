//
//  TextDelegate.h
//  GettingStarted
//
//  Created by Moch on 8/5/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// TextConfigure must declare as global variable or properyt
@interface TextConfigure : NSObject <UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, assign) NSUInteger maxLength;
// only text view use
@property (nonatomic, strong) UILabel *placeHolderLabel;

@end
