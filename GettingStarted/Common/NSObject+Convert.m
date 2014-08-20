//
//  NSObject+Convert.m
//  Category
//
//  Created by 肖川 on 14-5-26.
//  Copyright (c) 2014年 Moch. All rights reserved.
//

#import "NSObject+Convert.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObject (Convert)

- (instancetype)initWithProperties:(NSDictionary *)properties {
    
    if (self = [self init]) {
        [properties enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:[NSNull class]]) {
                obj = @"";
            }
            if ([key isEqualToString:@"id"]) {
                key = @"ID";
            }
            [self setValue:obj forKey:key];
        }];
    }
    
    return self;
}

#pragma mark - runtime

- (NSMutableArray *)properties {
    
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
    
    return propertyArray;
}

+ (NSMutableArray *)properties {
    
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
    
    return propertyArray;
}

- (NSDictionary *)convertToDictionary {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    // 获取本类属性列表字符串数组
    NSMutableArray *propertyArray = [self properties];
    
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dict setObject:[self valueForKey:obj] forKey:obj];
    }];
    
    return dict;
}

- (NSString *)toString {
    
    NSMutableString *desc = [[NSMutableString alloc] init];
    
    NSMutableArray *propertyArray = [self properties];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *string = [NSString stringWithFormat:@"%@ = %@, ", obj, [self valueForKey:obj]];
        [desc appendString:string];
        
    }];
    
    NSRange range = NSMakeRange([desc length] - 2, 1);
    [desc deleteCharactersInRange:range];
    
    return desc;
}


@end
