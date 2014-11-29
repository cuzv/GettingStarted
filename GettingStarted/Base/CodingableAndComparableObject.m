//
//  CodingableAndComparableObject.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CodingableAndComparableObject.h"
#import "NSObjectExtension.h"

#pragma mark - 可编码并且可以比较的对象

@implementation CodingableAndComparableObject

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [[self v_properties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [aCoder encodeObject:[self valueForKey:obj] forKey:obj];
    }];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [[self v_properties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
        }];
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    NSMutableArray *propertyArray = [self v_properties].mutableCopy;
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
    NSMutableArray *propertyArray = [[self v_properties] mutableCopy];
    __block NSUInteger hashCode = [self hash];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        hashCode ^= [[self valueForKey:obj] hash];
    }];
    
    return hashCode;
}

@end
