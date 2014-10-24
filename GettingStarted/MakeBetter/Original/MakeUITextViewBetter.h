//
//  MakeTextViewBetter.h
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MakeUITextViewBetter : NSObject
@end


#pragma mark - 可自动向下扩展的输入框

@interface ResizableTextView : UITextView

@property (nonatomic) CGFloat maximumHeight;
@property (nonatomic) CGFloat minimumHeight;
@property (nonatomic, copy) void (^didUpdateTextViewHeight)(ResizableTextView *textView);

@end
