//
//  CHXArrayDataSource.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/cuzv).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark -

@interface CHXArrayDataSourceSectionItem : NSObject

/**
 *  新建 CHXArrayDataSourceSectionItem 实例对象
 *
 *  @param content Cell 数据集合
 *
 *  @return CHXArrayDataSourceSectionItem 实例对象
 */
- (instancetype)initWithContent:(NSArray *)content;

@end

#pragma mark -

@interface CHXArrayDataSourceTableViewSectionItem : CHXArrayDataSourceSectionItem

/**
 *  新建 CHXArrayDataSourceTableViewSectionItem 实例对象
 *
 *  @param content        Cell 数据集合
 *  @param titleForHeader Section header
 *  @param titleForFooter Section footer
 *
 *  @return CHXArrayDataSourceTableViewSectionItem 实例对象
 */
- (instancetype)initWithContent:(NSArray *)content titleForHeader:(NSString *)titleForHeader titleForFooter:(NSString *)titleForFooter;

/**
 *  新建 CHXArrayDataSourceTableViewSectionItem 实例对象
 *
 *  @param content        Cell 数据集合
 *  @param titleForHeader Section header
 *  @param titleForFooter Section footer
 *  @param indexTitle     Section index
 *
 *  @return CHXArrayDataSourceTableViewSectionItem 实例对象
 */
- (instancetype)initWithContent:(NSArray *)content titleForHeader:(NSString *)titleForHeader titleForFooter:(NSString *)titleForFooter indexTitle:(NSString *)indexTitle;

@end

#pragma mark -

@interface CHXArrayDataSourceCollecionViewSectionItem : CHXArrayDataSourceSectionItem

/**
 *  新建 CHXArrayDataSourceCollecionViewSectionItem 实例对象
 *
 *  @param content                       Cell 数据集合
 *  @param supplementaryElementForHeader 头部数据
 *  @param supplementaryElementForFooter 尾部数据
 *
 *  @return CHXArrayDataSourceCollecionViewSectionItem 实例对象
 */
- (instancetype)initWithContent:(NSArray *)content supplementaryElementForHeader:(id)supplementaryElementForHeader supplementaryElementForFooter:(id)supplementaryElementForFooter;

@end

#pragma mark -

typedef NS_ENUM(NSInteger, CHXDataSourceType) {
    CHXDataSourceTypeSingleSection,
    CHXDataSourceTypeMultipleSection
};

// 配置 Cell 数据
typedef void (^CellConfigureBlock)(id cell, id item);
// 获取 Cell 重用标识
typedef NSString *(^CellReuseIdentifierForRowAtIndexPath)(NSIndexPath *indexPath);

// 是否允许编辑(删除或者添加)某一行 Cell
typedef BOOL (^CanEditRowAtIndexPath)(NSIndexPath *indexPath);
// 提交编辑的某一行 Cell，在这里面进行远程数据操作
typedef void (^CommitEditingForRowAtIndexPath)(UITableViewCellEditingStyle editingStyle, CHXArrayDataSourceSectionItem *item);
// 当前添加的 Cell 的位置
typedef void (^CurrentInsertRowAtIndexPath)(NSIndexPath *indexPath);

// 是否允许对 Cell 进行交换位置
typedef BOOL (^CanMoveRowAtIndexPath)(NSIndexPath *indexPath);

// 配置 Collection view 头部或者尾部视图的数据
typedef void (^ConfigureSupplementaryElementBlock)(UICollectionReusableView *view, id item);
// 获取 Collection view 头部或者尾部视图的重新标识
typedef NSString *(^CollectionSupplementaryElementReuseIdentifierForIndexPath)(NSIndexPath *indexPath, NSString *kind);

@interface CHXArrayDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

/**
 *  新建 CHXArrayDataSource 实例对象
 *
 *  @param dataSourceType                  数据源适用类型
 *  @param dataArray                       数据数组，元素必须为 CHXArrayDataSourceSectionItem 或者其子类对象
 *  @param cellReuseIdentifierForIndexPath Cell 重用标识
 *  @param configureBlock                  Cell 界面配置
 *
 *  @return CHXArrayDataSource 实例对象
 */
- (instancetype)initWithDataSourceType:(CHXDataSourceType)dataSourceType
                             dataArray:(NSMutableArray *)dataArray
       cellReuseIdentifierForIndexPath:(CellReuseIdentifierForRowAtIndexPath)cellReuseIdentifierForIndexPath
                    cellConfigureBlock:(CellConfigureBlock)configureBlock;

#pragma mark - 以下 Block 为可选配置

@property (nonatomic, copy) CanEditRowAtIndexPath canEditRowAtIndexPath;
@property (nonatomic, copy) CommitEditingForRowAtIndexPath commitEditingForRowAtIndexPath;
@property (nonatomic, copy) CurrentInsertRowAtIndexPath currentInsertRowAtIndexPath;

@property (nonatomic, copy) CanMoveRowAtIndexPath canMoveRowAtIndexPath;

@property (nonatomic, copy) CollectionSupplementaryElementReuseIdentifierForIndexPath collectionSupplementaryElementReuseIdentifierForIndexPath;
@property (nonatomic, copy) ConfigureSupplementaryElementBlock configureSupplementaryElementBlock;

@end


