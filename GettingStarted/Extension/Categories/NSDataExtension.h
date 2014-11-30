//
//  NSDataExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 11/20/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDataExtension : NSObject

@end


@interface NSData (CHXJSON)

/**
 *  Create a Foundation object from JSON data
 *
 *  @return Foundation object
 */
- (id)chx_JSONObject;

/**
 *  Generate JSON data from a Foundation object
 *
 *  @param object Foundation object
 *
 *  @return JSON data
 */
+ (NSData *)chx_dataWithJSONObject:(id)object;

/**
 *  Generate an JSON data from a property list
 *
 *  @param plist property list
 *
 *  @return JSON data
 */
+ (NSData *)chx_dataWithPropertyList:(id)plist;



@end

@interface NSData (CHXEncoding)

/**
 *  Generate UTF-8 string from data
 *
 *  @return UTF-8 string
 */
- (NSString *)chx_UTF8String;

/**
 *  Generate ASCII string form data
 *
 *  @return ASCII string
 */
- (NSString *)chx_ASCIIString;

/**
 *  Generate ISOLatin1 string form data
 *
 *  @return ISOLatin1 string
 */
- (NSString *)chx_ISOLatin1String;

@end