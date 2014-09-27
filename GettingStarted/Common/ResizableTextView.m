//
//  ResizableTextView.m
//  GettingStarted
//
//  Created by Moch on 9/27/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "ResizableTextView.h"

@interface ResizableTextView ()
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;
@end

@implementation ResizableTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)awakeFromNib {
    [self initial];
}

- (void)initial {
    // If we are using auto layouts, than get a handler to the height constraint.
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            self.heightConstraint = constraint;
            break;
        }
    }
    if (!self.heightConstraint) {
        // TODO: We might use auto layouts but set the height of the textView by using a top + bottom constraints.
        // In this case we would want to manually create a height constraint
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    BOOL autoLayoutEnabled = self.heightConstraint ? YES : NO;
    [self handleLayoutUsingAutoLayout:autoLayoutEnabled];
    
    // Center vertically
    // We're  supposed to have a maximum height contstarint in code for the text view which will makes
    // the intrinsicSide eventually higher then the height of the text view - if we had enough text.
    // This code only center vertically the text view while the context size is smaller/equal to the text view frame.
    if (self.intrinsicContentSize.height <= self.bounds.size.height) {
        CGFloat topCorrect = (self.bounds.size.height - self.contentSize.height * [self zoomScale]) / 2.0f;
        topCorrect = (topCorrect < .0f ? .0f : topCorrect);
        self.contentOffset = CGPointMake(0, -topCorrect);
    }
}

- (CGSize)intrinsicContentSize {
    CGSize intrinsicContentSize = self.contentSize;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        intrinsicContentSize.width += (self.textContainerInset.left + self.textContainerInset.right) / 2.0f;
        intrinsicContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom) / 2.0f;
    }
    
    return intrinsicContentSize;
}

- (void)handleLayoutUsingAutoLayout:(BOOL)autoLayoutsEnabled {
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
    if (_updateTextViewHeight) {
        _updateTextViewHeight(self);
    }
}

@end
