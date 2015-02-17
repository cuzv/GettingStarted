//
//  CHXCoreDataManager.h
//  GettingStarted
//
//  Created by Moch Xiao on 2/17/15.
//  Copyright (c) 2015 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern NSString *const CHXCoreDataRelationObjectPlaceholder;

@interface CHXCoreDataManager : NSObject

+ (void)saveContext;
+ (void)insertObjectWithEntityName:(NSString *)entityName
                relationEntityName:(NSString *)relationEntityName
                            params:(NSDictionary *)params
                    relationParams:(NSDictionary *)relationParams;
+ (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName
                        predicateFormat:(NSString *)predicateFormat;
+ (void)deleteObjectsWithEntityName:(NSString *)entityName
                    predicateFormat:(NSString *)predicateFormat;

@end
