//
//  ComparableObject.m
//  GettingStarted
//
//  Created by Moch on 8/21/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "ComparableObject.h"
#import "NSObject+Convert.h"

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
        
        if (!selfObject && !compareObject) {
            euqal = YES;
        } else {
            euqal = [[self valueForKey:obj] isEqual:[object valueForKey:obj]];
        }
        if (!euqal) {
            *stop = YES;
        }
    }];
    
    return euqal;
}

- (NSUInteger)hash {
    NSMutableArray *propertyArray = [self properties];
    __block NSUInteger hashCode = [self hash];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        hashCode ^= [[self valueForKey:obj] hash];
    }];
    
    return hashCode;
}

@end
