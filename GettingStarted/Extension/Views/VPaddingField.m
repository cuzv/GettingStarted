//
//  PaddingField.m
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "VPaddingField.h"

#pragma mark - 具有缩进效果的输入文本域
@implementation VPaddingField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
#define kPaddingWidth 5
// 控制 placeHolder 的位置，左右缩 5
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, kPaddingWidth , 0);
}

// 控制文本的位置，左右缩 5
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, kPaddingWidth , 0);
}


@end
