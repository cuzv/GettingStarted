//
//  NSString+TextSize.h
//  GettingStarted
//
//  Created by Moch on 8/22/14.
//  Copyright (c) 2014 BSG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TextSize)

- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width;

@end
