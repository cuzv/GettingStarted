//
//  TextDelegate.m
//  GettingStarted
//
//  Created by Moch on 8/5/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "TextConfigure.h"

@implementation TextConfigure

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maxCount = 100;
        _countLabel.bounds = CGRectMake(0, 0, 30, 22);
    }
    return self;
}

- (void)setCountLabel:(UILabel *)countLabel {
    if (![_countLabel isEqual:countLabel]) {
        _countLabel = countLabel;
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.bounds = CGRectMake(0, 0, 30, 22);
        _countLabel.textColor = [UIColor lightGrayColor];
        self.countLabel.text = [@(self.maxCount) stringValue];
    }
}

- (void)setMaxCount:(NSUInteger)maxCount {
    if (_maxCount != maxCount) {
        _maxCount = maxCount;
        self.countLabel.text = [@(self.maxCount) stringValue];
    }
}

- (void)setPlaceHolderLabel:(UILabel *)placeHolderLabel {
    if (![_placeHolderLabel isEqual:placeHolderLabel]) {
        _placeHolderLabel = placeHolderLabel;
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.text = _placeHolderLabel.text ? : @"请输入内容";
        _placeHolderLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
}

- (void)textDidChange:(NSNotification *)notification {
    NSUInteger length = 0;
    if ([notification.object isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)notification.object;
        length = textView.text.length;
    } else if ([notification.object isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)notification.object;
        length = textField.text.length;
    }
    _countLabel.text = [NSString stringWithFormat:@"%d", self.maxCount - length];
}

- (void)initialNotificationForObject:(id)object {
    static dispatch_once_t onceToken;
    if ([object isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)object;
        dispatch_once(&onceToken, ^{
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(textDidChange:)
                                                         name:UITextViewTextDidChangeNotification
                                                       object:textView];
        });
    } else if ([object isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)object;
        dispatch_once(&onceToken, ^{
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(textDidChange:)
                                                         name:UITextFieldTextDidChangeNotification
                                                       object:textField];
        });
    }
}

#pragma mark - text view delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self initialNotificationForObject:textView];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        [self.placeHolderLabel setHidden:YES];
    } else {
        [self.placeHolderLabel setHidden:NO];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(textView.text.length < 1) {
        [self.placeHolderLabel setHidden:NO];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (NSMaxRange(range) + text.length > self.maxCount){
        return NO;
    }
    if (text.length > 0) {
        if(self.countLabel.text.intValue > 0) {
            self.countLabel.text = [NSString stringWithFormat:@"%d",self.maxCount - (NSMaxRange(range) + text.length)];
            if(textView.text.length == self.maxCount - 1) {
                textView.text = [textView.text stringByAppendingString:text];
            }
        }
    } else {
        self.countLabel.text = [NSString stringWithFormat:@"%d",self.maxCount - (textView.text.length - range.length)];
    }

    if (self.countLabel && self.countLabel.text.intValue <= 0) {
        return NO;
    }
    return YES;
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self initialNotificationForObject:textField];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (NSMaxRange(range)+string.length > self.maxCount) {
        return NO;
    }
    if (string.length > 0) {
        if(self.countLabel.text.intValue > 0) {
            self.countLabel.text = [NSString stringWithFormat:@"%d",self.maxCount - (NSMaxRange(range) + string.length)];
            if(textField.text.length == self.maxCount - 1) {
                textField.text = [textField.text stringByAppendingString:string];
            }
        }
    } else {
        self.countLabel.text = [NSString stringWithFormat:@"%d",self.maxCount - (textField.text.length - range.length)];
    }
    if (self.countLabel.text.intValue <= 0) {
        return NO;
    }
    
    return YES;
}

@end
