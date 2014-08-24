//
//  PaddingLabel.m
//  GettingStarted
//
//  Created by Moch on 7/31/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "PaddingLabel.h"

@implementation PaddingLabel

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
