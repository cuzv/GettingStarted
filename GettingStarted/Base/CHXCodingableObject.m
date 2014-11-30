//
//  CodingableObject.m
//  GettingStarted
//
//  Created by Moch Xiao on 10/29/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import "CHXCodingableObject.h"
#import "NSObjectExtension.h"

#pragma mark - 可编码的对象
@implementation CHXCodingableObject

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [[self chx_properties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [aCoder encodeObject:[self valueForKey:obj] forKey:obj];
    }];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [[self chx_properties] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self setValue:[aDecoder decodeObjectForKey:obj] forKey:obj];
        }];
    }
    return self;
}


@end
