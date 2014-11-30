//
//  ArrayDataSource.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/24/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CellConfigureBlock)(id cell, id item);

@interface CHXArrayDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

/**
 *  初始化数据源(必须申明为属性)
 *
 *  @param cellIdentifier cell 重用标识
 *  @param items          数据
 *  @param configureBlock cell 配置回掉
 *
 *  @return 数据源
 */
- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier
                                 items:(NSArray *)items
                    cellConfigureBlock:(CellConfigureBlock)configureBlock;

/**
 *  获取数据
 *
 *  @param indexPath indexPath
 *
 *  @return 数据
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
