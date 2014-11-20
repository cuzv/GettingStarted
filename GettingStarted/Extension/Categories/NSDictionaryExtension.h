//
//  NSDictionaryExtension.h
//  GettingStarted
//
//  Created by Moch on 11/20/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionaryExtension : NSObject

@end


@interface NSDictionary (URLPath)

/**
 *  将字典转为链接参数形式
 *
 *  @return 链接字符串
 */
- (NSString *)URLParameterString;

@end