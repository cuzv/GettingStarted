//
//  TextEditConfigure.m
//  GettingStarted
//
//  Created by Moch Xiao on 10/24/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXTextEditConfigure.h"
#import <objc/runtime.h>

@interface CHXTextEditConfigure ()

@property (nonatomic, assign) BOOL UITextViewTextDidChangeNotificationRegistered;
@property (nonatomic, assign) UITextView *observedTextView;

@property (nonatomic, assign) BOOL UITextFieldTextDidChangeNotificationRegistered;
@property (nonatomic, weak) UITextField *observedTextField;

@end

@implementation CHXTextEditConfigure

- (void)dealloc {
    if (self.UITextFieldTextDidChangeNotificationRegistered) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.observedTextField];
    }
    if (self.UITextViewTextDidChangeNotificationRegistered) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self.observedTextView];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.maximumLength = 100;
        _countingLabel.bounds = CGRectMake(0, 0, 30, 22);
    }
    return self;
}

- (void)setCountingLabel:(UILabel *)countLabel {
    if (![_countingLabel isEqual:countLabel]) {
        _countingLabel = countLabel;
        _countingLabel.textAlignment = NSTextAlignmentRight;
        _countingLabel.bounds = CGRectMake(0, 0, 30, 22);
        _countingLabel.textColor = [UIColor lightGrayColor];
        if (!self.countingLabel.text) {
            self.countingLabel.text = [@(self.maximumLength) stringValue];
        }
    }
}

- (void)setMaximumLength:(NSUInteger)maxLength {
    if (_maximumLength != maxLength) {
        _maximumLength = maxLength;
        self.countingLabel.text = [@(self.maximumLength) stringValue];
    }
}

- (void)setPlaceHolderLabel:(UILabel *)placeHolderLabel {
    if (![_placeHolderLabel isEqual:placeHolderLabel]) {
        _placeHolderLabel = placeHolderLabel;
        _placeHolderLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.text = _placeHolderLabel.text ? : [NSString stringWithFormat:@"请输入不多于%@字的内容", @(self.maximumLength)];
    }
}

- (void)__initialNotificationForObject:(id)object {
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
    if ([object isKindOfClass:[UITextField class]]) {
        UITextField *textField = object;
        NSString *text = textField.text;
        if (text.length > self.maximumLength && !textField.markedTextRange) {
            textField.text = [text substringToIndex:self.maximumLength];
        }
        length = textField.text.length;
    } else if ([object isKindOfClass:[UITextView class]]){
        UITextView *textView = object;
        NSString *text = textView.text;
        if (textView.text.length > self.maximumLength && !textView.markedTextRange) {
            textView.text = [text substringToIndex:self.maximumLength];
        }
        length = textView.text.length;
        if (length) {
            [self.placeHolderLabel setHidden:YES];
        } else {
            [self.placeHolderLabel setHidden:NO];
        }
    }
    
    NSInteger remainCharactersCount = self.maximumLength - length;
    _countingLabel.text = [@(remainCharactersCount) stringValue];
    if (remainCharactersCount < 0) {
        _countingLabel.textColor = [UIColor redColor];
    } else {
        _countingLabel.textColor = [UIColor lightGrayColor];
    }
}

@end

#pragma mark - text field

static const void *UITextFieldKey = &UITextFieldKey;

@implementation UITextField (TextConfigure)

- (void)chx_setTextConfigure:(CHXTextEditConfigure *)textConfigure {
    [self willChangeValueForKey:@"UITextFieldKey"];
    objc_setAssociatedObject(self, UITextFieldKey, textConfigure, OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"UITextFieldKey"];
    
    [textConfigure __initialNotificationForObject:self];
}

- (CHXTextEditConfigure *)chx_textConfigure {
    return objc_getAssociatedObject(self, &UITextFieldKey);
}

@end

#pragma mark - text view

static const void *UITextViewKey = &UITextViewKey;

@implementation UITextView (TextConfigure)

- (void)chx_setTextConfigure:(CHXTextEditConfigure *)textConfigure {
	[self willChangeValueForKey:@"UITextViewKey"];
	objc_setAssociatedObject(self, UITextViewKey, textConfigure, OBJC_ASSOCIATION_RETAIN);
	[self didChangeValueForKey:@"UITextViewKey"];
	
	[textConfigure __initialNotificationForObject:self];
}

- (CHXTextEditConfigure *)chx_textConfigure {
	return objc_getAssociatedObject(self, &UITextViewKey);
}


@end
