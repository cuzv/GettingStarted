//
//  MakeNSObjectBetter.m
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "MakeNSObjectBetter.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation MakeNSObjectBetter
@end

#pragma mark - 对象模型与原生类型间的转换

@implementation NSObject (Convert)

- (instancetype)initWithProperties:(NSDictionary *)properties {
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:properties];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    } else {
        NSLog(@"UndefinedKey: %@", key);
    }
}

// runtime
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
    if (![self.properties count]) {
        return nil;
    }
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


#pragma mark - 可比较的对象

@implementation ComparableObject

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    NSMutableArray *propertyArray = [self properties].mutableCopy;
    __block BOOL euqal = YES;
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id selfObject = [self valueForKey:obj];
        id compareObject = [object valueForKey:obj];
        euqal = [selfObject isEqual:compareObject];
        
        if (!euqal && selfObject && compareObject) {
            *stop = YES;
        } else {
            euqal = YES;
        }
    }];
    
    return euqal;
}

- (NSUInteger)hash {
    NSMutableArray *propertyArray = [[self properties] mutableCopy];
    __block NSUInteger hashCode = [self hash];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        hashCode ^= [[self valueForKey:obj] hash];
    }];
    
    return hashCode;
}

@end


#pragma mark - 可编码的对象

@implementation CodingableObject

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [aCoder encodeObject:[self valueForKey:obj] forKey:obj];
    }];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
        }];
    }
    return self;
}

@end


#pragma mark - 可编码并且可以比较的对象

@implementation CodingableAndComparableObject

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [aCoder encodeObject:[self valueForKey:obj] forKey:obj];
    }];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
        }];
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    NSMutableArray *propertyArray = [self properties].mutableCopy;
    __block BOOL euqal = YES;
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id selfObject = [self valueForKey:obj];
        id compareObject = [object valueForKey:obj];
        euqal = [selfObject isEqual:compareObject];
        
        if (!euqal && selfObject && compareObject) {
            *stop = YES;
        } else {
            euqal = YES;
        }
    }];
    
    return euqal;
}

- (NSUInteger)hash {
    NSMutableArray *propertyArray = [[self properties] mutableCopy];
    __block NSUInteger hashCode = [self hash];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        hashCode ^= [[self valueForKey:obj] hash];
    }];
    
    return hashCode;
}

@end
