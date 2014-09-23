//
//  TextDelegate.h
//  GettingStarted
//
//  Created by Moch on 8/5/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TextConfigure : NSObject

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, assign) NSUInteger maxLength;
// only text view use
@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@interface UITextView (TextConfigure)
@property (nonatomic, strong) TextConfigure *textConfigure;
@end

@interface UITextField (TextConfigure)
@property (nonatomic, strong) TextConfigure *textConfigure;
@end