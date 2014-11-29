//
//  ResizableTextView.h
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark - 可自动向下扩展的输入框

@interface VFlexibleTextView : UITextView

@property (nonatomic) CGFloat maximumHeight;
@property (nonatomic) CGFloat minimumHeight;
@property (nonatomic, copy) void (^didUpdateTextViewHeight)(VFlexibleTextView *textView);

@end
