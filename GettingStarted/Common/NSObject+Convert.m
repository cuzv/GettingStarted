//
//  NSObject+Convert.m
//  GettingStarted
//
//  Created by Moch on 14-5-26.
//  Copyright (c) 2014年 Moch. All rights reserved.
//

#import "NSObject+Convert.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObject (Convert)

- (instancetype)initWithProperties:(NSDictionary *)properties {
    if (self = [self init]) {
        NSArray *selfPropertyKeys = [self properties];
        [selfPropertyKeys enumerateObjectsWithOptions:NSSortConcurrent
                                           usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqualToString:@"id"]) {
                obj = @"ID";
            }
            id value = [properties valueForKey:obj];
            if ([value isKindOfClass:[NSNull class]]) {
                value = @"";
            }
            [self setValue:value forKey:obj];
        }];
    }
    
    return self;
}

#pragma mark - runtime

- (NSArray *)properties {
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

+ (NSArray *)properties {
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

- (NSDictionary *)convertToDictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    // 获取本类属性列表字符串数组
    NSMutableArray *propertyArray = [[self properties] mutableCopy];
    
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dict setObject:[self valueForKey:obj] forKey:obj];
    }];
    
    return dict;
}

- (NSString *)toString {
    NSMutableString *desc = [[NSMutableString alloc] init];
    
    NSMutableArray *propertyArray = [[self properties] mutableCopy];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *string = [NSString stringWithFormat:@"%@ = %@, ", obj, [self valueForKey:obj]];
        [desc appendString:string];
        
    }];
    
    NSRange range = NSMakeRange([desc length] - 2, 1);
    [desc deleteCharactersInRange:range];
    
    return desc;
}


@end
