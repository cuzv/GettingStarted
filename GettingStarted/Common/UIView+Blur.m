//
//  UIView+Blur.m
//  GettingStarted
//
//  Created by Moch on 9/2/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UIView+Blur.h"

@implementation UIView (Blur)

- (void)blur {
    self.backgroundColor = [UIColor clearColor];
    UIToolbar *backgroundToolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
    backgroundToolbar.barStyle = UIBarStyleDefault;
    backgroundToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundToolbar.clipsToBounds = YES;
    [self insertSubview:backgroundToolbar atIndex:0];
}

@end
