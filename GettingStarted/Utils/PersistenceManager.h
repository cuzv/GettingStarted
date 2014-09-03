//
//  PersistenceManager.h
//  GettingStarted
//
//  Created by Moch on 9/3/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistenceManager : NSObject

+ (BOOL)persistenceValue:(id)value forKey:(NSString *)key;
+ (id)persistenceValueForKey:(NSString *)key;

@end
