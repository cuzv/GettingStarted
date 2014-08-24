//
//  TextDelegate.h
//  GettingStarted
//
//  Created by Moch on 8/5/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextConfigure : NSObject <UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, strong) UILabel *placeHolderLabel; // only text view use

@end
