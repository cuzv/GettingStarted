//
//  UITextViewExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UITextViewExtension.h"
#import "UIViewExtension.h"

@implementation UITextViewExtension

@end


#pragma mark - 快速创建文本框

@implementation UITextView (CHXGenerate)

+ (instancetype)chx_textViewWithFrame:(CGRect)frame
                                 font:(UIFont *)font
                             delegate:(id<UITextViewDelegate>)delegate
                   displayBorderLayer:(BOOL)display {
    UITextView *textView = [[self alloc] initWithFrame:frame];
    textView.font = font ? : [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    textView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    textView.autocorrectionType = UITextAutocorrectionTypeDefault;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textView.delegate = delegate;
    
    if (display) {
        [textView chx_setCornerRadius:5];
        [textView chx_setBorderWidth:0.5 color:[UIColor lightGrayColor]];
    }
    
    return textView;
}

+ (instancetype)chx_textViewWithSize:(CGSize)size
                              center:(CGPoint)center
                                font:(UIFont *)font
                            delegate:(id<UITextViewDelegate>)delegate
                  displayBorderLayer:(BOOL)display {
    CGRect frame = CGRectMake(center.x - size.width / 2,
                              center.y - size.height / 2,
                              size.width,
                              size.height);
    return [self chx_textViewWithFrame:frame font:font delegate:delegate displayBorderLayer:display];
}

@end
