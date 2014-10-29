//
//  UITableViewCategories.h
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableViewCategories : NSObject

@end

#pragma mark - 快速创建表视图

@interface UITableView (Generate)

/**
 *  快速生成表视图
 *
 *  @param frame      位置
 *  @param style      样式
 *  @param dataSource 数据源
 *  @param delegate   委托
 *
 *  @return 表视图
 */
+ (instancetype)tableViewWithFrame:(CGRect)frame
                             style:(UITableViewStyle)style
                         dataSouce:(id <UITableViewDataSource>)dataSource
                          delegate:(id <UITableViewDelegate>) delegate;


/**
 *  快速生成表视图
 *
 *  @param size       大小
 *  @param center     中心点
 *  @param style      样式
 *  @param dataSource 数据源
 *  @param delegate   委托
 *
 *  @return 表视图
 */
+ (instancetype)tableViewWithSize:(CGSize)size
                           center:(CGPoint)center
                            style:(UITableViewStyle)style
                        dataSouce:(id <UITableViewDataSource>)dataSource
                         delegate:(id <UITableViewDelegate>) delegate;
@end
