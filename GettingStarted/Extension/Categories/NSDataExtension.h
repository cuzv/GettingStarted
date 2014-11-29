//
//  NSDataExtension.h
//  GettingStarted
//
//  Created by Moch on 11/20/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDataExtension : NSObject

@end


@interface NSData (VJSON)

/**
 *  Create a Foundation object from JSON data
 *
 *  @return Foundation object
 */
- (id)v_JSONObject;

/**
 *  Generate JSON data from a Foundation object
 *
 *  @param object Foundation object
 *
 *  @return JSON data
 */
+ (NSData *)v_dataWithJSONObject:(id)object;

/**
 *  Generate an JSON data from a property list
 *
 *  @param plist property list
 *
 *  @return JSON data
 */
+ (NSData *)v_dataWithPropertyList:(id)plist;



@end

@interface NSData (VEncoding)

/**
 *  Generate UTF-8 string from data
 *
 *  @return UTF-8 string
 */
- (NSString *)v_UTF8String;

/**
 *  Generate ASCII string form data
 *
 *  @return ASCII string
 */
- (NSString *)v_ASCIIString;

/**
 *  Generate ISOLatin1 string form data
 *
 *  @return ISOLatin1 string
 */
- (NSString *)v_ISOLatin1String;

@end