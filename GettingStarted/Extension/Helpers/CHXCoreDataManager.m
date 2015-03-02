//
//  CHXCoreDataManager.m
//  GettingStarted
//
//  Created by Moch Xiao on 2/17/15.
//  Copyright (c) 2015 Foobar. All rights reserved.
//

#import "CHXCoreDataManager.h"

@interface CHXCoreDataClient : NSObject 
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation CHXCoreDataClient

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)pr_applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.foobar.CoreDataDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }

    NSString *bundleName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSString *bundleName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    NSURL *storeURL = [[self pr_applicationDocumentsDirectory] URLByAppendingPathComponent:[bundleName stringByAppendingString:@".sqlite"]];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
//    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Shared Instance

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CHXCoreDataClient *_sharedInstance;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self new];
    });

    return _sharedInstance;
}

@end

#pragma mark - Manager method

NSString *const CHXCoreDataRelationObjectPlaceholder = @"RelationObject";

@implementation CHXCoreDataManager

+ (void)saveContext {
    [[CHXCoreDataClient sharedInstance] saveContext];
}

#pragma mark - CRUD

+ (void)insertObjectWithEntityName:(NSString *)entityName
                relationEntityName:(NSString *)relationEntityName
                            params:(NSDictionary *)params
                    relationParams:(NSDictionary *)relationParams {
    // 为空判断：使方法变得更健壮
    NSManagedObjectContext *context = [[CHXCoreDataClient sharedInstance] managedObjectContext];
    if (!context ||
        entityName.length == 0 ||
        relationEntityName.length == 0 ||
        ([params count] == 0 && [relationParams count] == 0)) {
        return;
    }
    // 创建基础对象
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                            inManagedObjectContext:context];
    // 创建关系对象
    NSManagedObject *relationObject = [NSEntityDescription insertNewObjectForEntityForName:relationEntityName
                                                                    inManagedObjectContext:context];
    // 基础对象数据配置
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        // 处理关系建立
        if ([value isEqualToString:CHXCoreDataRelationObjectPlaceholder]) {
            [object setValue:relationObject forKey:key];
        } else {
            [object setValue:value forKey:key];
        }
    }

    // 关系对象数据配置
    for (NSString *key in relationParams) {
        id value = [relationParams objectForKey:key];
        // 处理关系建立
        if ([value isEqualToString:CHXCoreDataRelationObjectPlaceholder]) {
            [relationObject setValue:object forKey:key];
        } else {
            [relationObject setValue:value forKey:key];
        }
    }
    // 保存上下文
    NSError *error = nil;
    BOOL success = [context save:&error];
    NSAssert(success, @"Insert operation did failed with error message '%@'.",
             [error localizedDescription]);
}

+ (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName
                        predicateFormat:(NSString *)predicateFormat {
    NSManagedObjectContext *context = [[CHXCoreDataClient sharedInstance] managedObjectContext];
    if (!context || entityName.length == 0) {
        return nil;
    }
    // 初始化检索请求
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // 配置检索条件，NSPredicate谓词
    if (predicateFormat.length > 0) {
        fetchRequest.predicate = [NSPredicate predicateWithFormat:predicateFormat];
    }
    // 执行检索请求
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    NSAssert(!error, @"NSManagedObjectContext fetch operation did failed with error message '%@'.",
             [error localizedDescription]);
    return objects;
}

+ (void)deleteObjectsWithEntityName:(NSString *)entityName
                    predicateFormat:(NSString *)predicateFormat {
    NSManagedObjectContext *context = [[CHXCoreDataClient sharedInstance] managedObjectContext];
    // 为空判断
    if (!context || entityName.length == 0) {
        return;
    }
    // 数据查询
    NSArray *objects = [self fetchObjectsWithEntityName:entityName
                                        predicateFormat:predicateFormat];
    // 数据删除
    if ([objects count] > 0) {
        for (id object in objects) {
            // 从上下文中删除数据
            [context deleteObject:object];
        }
        NSError *error = nil;
        BOOL success = [context save:&error];
        NSAssert(success, @"NSManagedObjectContext delete operation failed with error message '%@'.",
                 [error localizedDescription]);
    }
}


@end
