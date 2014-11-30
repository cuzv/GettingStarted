//
//  ResizableTextView.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/24/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark - 可自动向下扩展的输入框

@interface CHXFlexibleTextView : UITextView

@property (nonatomic) CGFloat maximumHeight;
@property (nonatomic) CGFloat minimumHeight;
@property (nonatomic, copy) void (^didUpdateTextViewHeight)(CHXFlexibleTextView *textView);

@end
