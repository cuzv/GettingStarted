//
//  TextDelegate.m
//  GettingStarted
//
//  Created by Moch on 8/5/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "TextConfigure.h"
#import <objc/runtime.h>

@interface TextConfigure ()

@property (nonatomic, assign) BOOL UITextViewTextDidChangeNotificationRegistered;
@property (nonatomic, assign) UITextView *observedTextView;

@property (nonatomic, assign) BOOL UITextFieldTextDidChangeNotificationRegistered;
@property (nonatomic, weak) UITextField *observedTextField;

@end

@implementation TextConfigure

- (void)dealloc {
    if (self.UITextFieldTextDidChangeNotificationRegistered) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.observedTextField];
    }
    if (self.UITextViewTextDidChangeNotificationRegistered) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self.observedTextView];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxLength = 100;
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
        self.countLabel.text = [@(self.maxLength) stringValue];
    }
}

- (void)setMaxLength:(NSUInteger)maxLength {
    if (_maxLength != maxLength) {
        _maxLength = maxLength;
        self.countLabel.text = [@(self.maxLength) stringValue];
    }
}

- (void)setPlaceHolderLabel:(UILabel *)placeHolderLabel {
    if (![_placeHolderLabel isEqual:placeHolderLabel]) {
        _placeHolderLabel = placeHolderLabel;
        _placeHolderLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.text = _placeHolderLabel.text ? : [NSString stringWithFormat:@"请输入不多于%d字的内容", self.maxLength];
    }
}

- (void)initialNotificationForObject:(id)object {
    if ([object isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)object;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textDidChange:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:textView];
        self.UITextViewTextDidChangeNotificationRegistered = YES;
        self.observedTextView = textView;
    } else if ([object isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)object;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        self.UITextFieldTextDidChangeNotificationRegistered = YES;
        self.observedTextField = textField;
    }
}

#pragma mark - text did change notification

- (void)textDidChange:(NSNotification *)notification {
    NSUInteger length = 0;
    id object = notification.object;
    if ([object isMemberOfClass:[UITextField class]]) {
        UITextField *textField = object;
        NSString *text = textField.text;
        if (text.length > self.maxLength && !textField.markedTextRange) {
            textField.text = [text substringToIndex:self.maxLength];
        }
        length = textField.text.length;
    } else if ([object isMemberOfClass:[UITextView class]]){
        UITextView *textView = object;
        NSString *text = textView.text;
        if (textView.text.length > self.maxLength && !textView.markedTextRange) {
            textView.text = [text substringToIndex:self.maxLength];
        }
        length = textView.text.length;
        if (length) {
            [self.placeHolderLabel setHidden:YES];
        } else {
            [self.placeHolderLabel setHidden:NO];
        }
    }
    
    _countLabel.text = [NSString stringWithFormat:@"%d", self.maxLength - length];
}

@end

#pragma mark - text field

static const void *UITextFieldKey = &UITextFieldKey;

@implementation UITextField (TextConfigure)

- (void)setTextConfigure:(TextConfigure *)textConfigure {
    [self willChangeValueForKey:@"UITextFieldKey"];
    objc_setAssociatedObject(self, UITextFieldKey, textConfigure, OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"UITextFieldKey"];
    
    [textConfigure initialNotificationForObject:self];
}

- (TextConfigure *)textConfigure {
    return objc_getAssociatedObject(self, &UITextFieldKey);
}

@end

#pragma mark - text view

static const void *UITextViewKey = &UITextViewKey;

@implementation UITextView (TextConfigure)

- (void)setTextConfigure:(TextConfigure *)textConfigure {
    [self willChangeValueForKey:@"UITextViewKey"];
    objc_setAssociatedObject(self, UITextViewKey, textConfigure, OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"UITextViewKey"];
    
    [textConfigure initialNotificationForObject:self];
}

- (TextConfigure *)textConfigure {
    return objc_getAssociatedObject(self, &UITextViewKey);
}


@end
