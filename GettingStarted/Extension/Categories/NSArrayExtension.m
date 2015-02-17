//
//  NSArrayExtension.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-26.
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

#import "NSArrayExtension.h"
#import "NSStringExtension.h"
#import "CHXGlobalServices.h"

@implementation NSArrayExtension

@end

#pragma mark - Override NSArray Description

static NSString *format = @"";

@implementation NSArray (CHXDescription)

- (NSString *)chx_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSString *desc = [self chx_descriptionWithLocale:locale indent:level];
    
    return [desc chx_UTF8StringCharacterEscape];
}

#ifdef DEBUG
+ (void)load {
    chx_swizzleInstanceMethod([self class], @selector(descriptionWithLocale:indent:), @selector(chx_descriptionWithLocale:indent:));
}
#endif

@end