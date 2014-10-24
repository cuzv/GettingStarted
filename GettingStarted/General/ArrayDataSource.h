//
//  ArrayDataSource.h
//  GettingStarted
//
//  Created by Moch on 9/26/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellConfigureBlock)(id cell, id item);

@interface ArrayDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

/**
 * Note: Must use as property, that will hold instance untill call dealloc
 */
- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier items:(NSArray *)items cellConfigureBlock:(CellConfigureBlock)configureBlock;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
