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


@interface NSData (JSON)

/**
 *  Create a Foundation object from JSON data
 *
 *  @return Foundation object
 */
- (id)JSONObject;

/**
 *  Generate JSON data from a Foundation object
 *
 *  @param object Foundation object
 *
 *  @return JSON data
 */
+ (NSData *)dataWithJSONObject:(id)object;

/**
 *  Generate an JSON data from a property list
 *
 *  @param plist property list
 *
 *  @return JSON data
 */
+ (NSData *)dataWithPropertyList:(id)plist;



@end

@interface NSData (Encoding)

/**
 *  Generate UTF-8 string from data
 *
 *  @return UTF-8 string
 */
- (NSString *)UTF8String;

/**
 *  Generate ASCII string form data
 *
 *  @return ASCII string
 */
- (NSString *)ASCIIString;

/**
 *  Generate ISOLatin1 string form data
 *
 *  @return ISOLatin1 string
 */
- (NSString *)ISOLatin1String;

@end