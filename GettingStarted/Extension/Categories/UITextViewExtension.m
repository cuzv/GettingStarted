//
//  UITextViewExtension.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UITextViewExtension.h"
#import "UIViewExtension.h"

@implementation UITextViewExtension

@end


#pragma mark - 快速创建文本框

@implementation UITextView (Generate)

+ (instancetype)textViewWithFrame:(CGRect)frame
                             font:(UIFont *)font
                         delegate:(id <UITextViewDelegate>)delegate
               displayBorderLayer:(BOOL)display {
    UITextView *textView = [[self alloc] initWithFrame:frame];
    textView.font = font ? : [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    textView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    textView.autocorrectionType = UITextAutocorrectionTypeDefault;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textView.delegate = delegate;
    
    if (display) {
        [textView setCornerRadius:5];
        [textView setBorderWidth:0.5 color:[UIColor lightGrayColor]];
    }
    
    return textView;
}

+ (instancetype)textViewWithSize:(CGSize)size
                          center:(CGPoint)center
                             font:(UIFont *)font
                         delegate:(id <UITextViewDelegate>)delegate
              displayBorderLayer:(BOOL)display {
    CGRect frame = CGRectMake(center.x - size.width / 2,
                              center.y - size.height / 2,
                              size.width,
                              size.height);
    return [self textViewWithFrame:frame font:font delegate:delegate displayBorderLayer:display];
}

@end
