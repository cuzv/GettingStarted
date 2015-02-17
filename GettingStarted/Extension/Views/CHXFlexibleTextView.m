//
//  CHXFlexibleTextView.m
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

#import "CHXFlexibleTextView.h"

#pragma mark - 可自动向下扩展的输入框

@interface CHXFlexibleTextView ()
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;
@end

@implementation CHXFlexibleTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self pr_initial];
    }
    return self;
}

- (void)awakeFromNib {
    [self pr_initial];
}

- (void)pr_initial {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            self.heightConstraint = constraint;
            break;
        }
    }
    if (!self.heightConstraint) {
        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BOOL autoLayoutEnabled = self.heightConstraint ? YES : NO;
    [self pr_handleLayoutUsingAutoLayout:autoLayoutEnabled];
    
    if ([self pr_initialContentSizeHeight] <= self.bounds.size.height) {
        CGFloat topCorrect = (self.bounds.size.height - self.contentSize.height * [self zoomScale]) / 2.0f;
        topCorrect = (topCorrect < .0f ? .0f : topCorrect);
        self.contentOffset = CGPointMake(0, -topCorrect);
    }
}

- (CGFloat)pr_initialContentSizeHeight {
    CGSize initialContentSize = self.contentSize;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        initialContentSize.width += (self.textContainerInset.left + self.textContainerInset.right) / 2.0f;
        initialContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom) / 2.0f;
    }
    
    return initialContentSize.height;
}

- (void)pr_handleLayoutUsingAutoLayout:(BOOL)autoLayoutsEnabled {
    CGFloat currentHeight = self.contentSize.height;
    if (self.minimumHeight) {
        currentHeight = MAX(self.minimumHeight, currentHeight);
    }
    if (self.maximumHeight) {
        currentHeight = MIN(self.maximumHeight, currentHeight);
    }
    
    if (autoLayoutsEnabled) {
        self.heightConstraint.constant = currentHeight;
    } else {
        CGRect selfFrame = self.frame;
        selfFrame.size.height = currentHeight;
        self.frame = selfFrame;
    }
    
    self.contentOffset = CGPointMake(0, self.contentSize.height - currentHeight);
    if (_didUpdateTextViewHeight) {
        _didUpdateTextViewHeight(self);
    }
}

@end
