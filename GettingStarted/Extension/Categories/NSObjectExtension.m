//
//  NSObjectExtension.m
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

#import "NSObjectExtension.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObjectExtension

@end

#pragma mark - 对象模型与原生类型间的转换

@implementation NSObject (CHXConvert)

- (instancetype)chx_initWithProperties:(NSDictionary *)properties {
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:properties];
    };
    
    return self;
}

// KVC
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    } else {
        NSLog(@"UndefinedKey: %@", key);
    }
}

// Runtime
- (NSArray *)chx_properties {
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *stringName = [NSString  stringWithCString:propertyName
                                                   encoding:NSUTF8StringEncoding];
        [propertyArray addObject:stringName];
    }
    
    free(propertyList);
    
    return [[NSArray alloc] initWithArray:propertyArray];
}

+ (NSArray *)chx_properties {
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *stringName = [NSString  stringWithCString:propertyName
                                                   encoding:NSUTF8StringEncoding];
        [propertyArray addObject:stringName];
    }
    
    free(propertyList);
    
    return [[NSArray alloc] initWithArray:propertyArray];
}

- (NSArray *)chx_methods {
    NSMutableArray *methodsArray = [NSMutableArray new];
    u_int count;
    Method *methodsList = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        SEL methodSelector = method_getName(methodsList[i]);
        NSString *stringName = NSStringFromSelector(methodSelector);
        [methodsArray addObject:stringName];
    }
    
    return [NSArray arrayWithArray:methodsArray];
}

+ (NSArray *)chx_methods {
    NSMutableArray *methodsArray = [NSMutableArray new];
    u_int count;
    Method *methodsList = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        SEL methodSelector = method_getName(methodsList[i]);
        NSString *stringName = NSStringFromSelector(methodSelector);
        [methodsArray addObject:stringName];
    }
    
    return [NSArray arrayWithArray:methodsArray];
}

- (NSDictionary *)chx_convertToDictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    // 获取本类属性列表字符串数组
    NSMutableArray *propertyArray = [[self chx_properties] mutableCopy];
    
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dict setObject:[self valueForKey:obj] forKey:obj];
    }];
    
    return dict;
}

- (NSString *)chx_toString {
    if (![[self chx_properties] count]) {
        return nil;
    }
    
    NSMutableDictionary *propertyDictionary = [NSMutableDictionary new];
    NSMutableArray *propertyArray = [[self chx_properties] mutableCopy];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [propertyDictionary setObject:[self valueForKey:obj] forKey:obj];
    }];
    
    NSString *description = [NSString stringWithFormat:@"<%@: %p, %@>", [self class], self, propertyDictionary];
    
    return description;
}

@end

