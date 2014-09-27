//
//  ResizableTextView.h
//  GettingStarted
//
//  Created by Moch on 9/27/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResizableTextView : UITextView

@property (nonatomic) CGFloat maximumHeight;
@property (nonatomic) CGFloat minimumHeight;
@property (nonatomic, copy) void (^updateTextViewHeight)(ResizableTextView *textView);

@end
