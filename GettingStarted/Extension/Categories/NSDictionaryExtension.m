//
//  NSDictionaryExtension.m
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

#import "NSDictionaryExtension.h"
#import "NSStringExtension.h"
#import "CHXGlobalServices.h"

@implementation NSDictionaryExtension

@end

@implementation NSDictionary (CHXURLPath)

// Convert dictionary to url string
- (NSString *)chx_URLParameterString {
    NSAssert([self isKindOfClass:[NSDictionary class]],
             @"The input parameters is not dictionary type!");
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] initWithDictionary:self];
    NSMutableString *URLParamMutableString = [NSMutableString new];
    [paramDic keysOfEntriesWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id key, id obj, BOOL *stop) {
        [URLParamMutableString appendFormat:@"%@=%@&", key, obj];
        return NO;
    }];
    NSString *URLParamString = [URLParamMutableString substringToIndex:URLParamMutableString.length - 1];
    
    return URLParamString;
}

@end

#pragma mark - Override NSDictionary Description

@implementation NSDictionary (CHXDescription)

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