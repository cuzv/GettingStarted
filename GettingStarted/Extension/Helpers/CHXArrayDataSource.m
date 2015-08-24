//
//  CHXArrayDataSource.m
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

#import "CHXArrayDataSource.h"

#pragma mark -

@interface CHXArrayDataSourceSectionItem ()
@property (nonatomic, strong) NSArray *content;
@end

@implementation CHXArrayDataSourceSectionItem

- (instancetype)initWithContent:(NSArray *)content {
    if (self = [super init]) {
        _content = content;
    }
    
    return self;
}

@end

#pragma mark -

@interface CHXArrayDataSourceTableViewSectionItem ()
@property (nonatomic, copy) NSString *titleForHeader;
@property (nonatomic, copy) NSString *titleForFooter;
@property (nonatomic, copy) NSString *indexTitle;
@end

@implementation CHXArrayDataSourceTableViewSectionItem

- (instancetype)initWithContent:(NSArray *)content
                 titleForHeader:(NSString *)titleForHeader
                 titleForFooter:(NSString *)titleForFooter {
    return [self initWithContent:content titleForHeader:titleForHeader titleForFooter:titleForFooter indexTitle:nil];
}

- (instancetype)initWithContent:(NSArray *)content
                 titleForHeader:(NSString *)titleForHeader
                 titleForFooter:(NSString *)titleForFooter
                     indexTitle:(NSString *)indexTitle {
    if (self = [super initWithContent:content]) {
        _titleForHeader = titleForHeader;
        _titleForFooter = titleForFooter;
        _indexTitle = indexTitle;
    }
    
    return self;
}

@end

#pragma mark -

@interface CHXArrayDataSourceCollecionViewSectionItem ()
@property (nonatomic, strong) id supplementaryElementForHeader;
@property (nonatomic, strong) id supplementaryElementForFooter;
@end

@implementation CHXArrayDataSourceCollecionViewSectionItem

- (instancetype)initWithContent:(NSArray *)content
  supplementaryElementForHeader:(id)supplementaryElementForHeader
  supplementaryElementForFooter:(id)supplementaryElementForFooter {
    if (self = [super initWithContent:content]) {
        _supplementaryElementForHeader = supplementaryElementForHeader;
        _supplementaryElementForFooter = supplementaryElementForFooter;
    }
    
    return self;
}

@end

#pragma mark -

@interface CHXArrayDataSource ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) CHXDataSourceType dataSourceType;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;
@property (nonatomic, copy) CellReuseIdentifierForRowAtIndexPath cellReuseIdentifierForIndexPath;
@end

NSString *const kNoneCollectionSectionHeaderIdentifier = @"NoneUICollectionElementKindSectionHeader";
NSString *const kNoneCollectionSectionFooterIdentifier = @"NoneUICollectionElementKindSectionFooter";

@implementation CHXArrayDataSource

- (instancetype)init {
    NSAssert(NO, @"Please use designed initialized construct mthod !");
    return nil;
}

- (instancetype)initWithDataSourceType:(CHXDataSourceType)dataSourceType
                             dataArray:(NSMutableArray *)dataArray
       cellReuseIdentifierForIndexPath:(CellReuseIdentifierForRowAtIndexPath)cellReuseIdentifierForIndexPath
                    cellConfigureBlock:(CellConfigureBlock)configureBlock {
    if (self = [super init]) {
        self.dataSourceType = dataSourceType;
        self.items = dataArray;
        self.cellReuseIdentifierForIndexPath = cellReuseIdentifierForIndexPath;
        self.configureCellBlock = configureBlock;
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self pr_numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self pr_numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = self.cellReuseIdentifierForIndexPath(indexPath);
    NSParameterAssert(identifier);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];;
    
    id item = [self pr_itemAtIndexPath:indexPath];
    
    self.configureCellBlock(cell, item);
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id item = self.items[section];
    
    if ([item class] != NSClassFromString(@"CHXArrayDataSourceTableViewSectionItem")) {
        return nil;
    }
    
    return [item titleForHeader];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    id item = self.items[section];
    
    if ([item class] != NSClassFromString(@"CHXArrayDataSourceTableViewSectionItem")) {
        return nil;
    }
    
    return [item titleForFooter];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self.items.firstObject class] != NSClassFromString(@"CHXArrayDataSourceTableViewSectionItem")) {
        return nil;
    }
    
    return [self.items valueForKey:@"indexTitle"];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[self.items valueForKey:@"indexTitle"] indexOfObject:title];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.canEditRowAtIndexPath) {
        return NO;
    }
    
    return self.canEditRowAtIndexPath(indexPath);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.commitEditingForRowAtIndexPath) {
        // UI Editing
        CHXArrayDataSourceSectionItem *editingItem = [self pr_itemAtIndexPath:indexPath];
        id item = self.items[indexPath.section];
        NSMutableArray *content = [[item content] mutableCopy];
        
        if (UITableViewCellEditingStyleDelete == editingStyle) {
            [content removeObjectAtIndex:indexPath.row];
            [item setContent:[NSArray arrayWithArray:content]];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if (UITableViewCellEditingStyleInsert == editingStyle) {
            // Duplicate last content item, in case reload data error, should not use it.
            [content insertObject:content.lastObject atIndex:indexPath.row];
            [item setContent:[NSArray arrayWithArray:content]];
            
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
            if (self.currentInsertRowAtIndexPath) {
                self.currentInsertRowAtIndexPath(newIndexPath);
            }
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        // Remote Editing
        self.commitEditingForRowAtIndexPath(editingStyle, editingItem);
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL can = NO;
    if (self.canMoveRowAtIndexPath) {
        can = self.canMoveRowAtIndexPath(indexPath);
    }
    return can;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    CHXArrayDataSourceSectionItem *sourceItem = self.items[sourceIndexPath.section];
    NSMutableArray *sourceContent = [sourceItem.content mutableCopy];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [sourceContent exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    } else {
        id temp = [sourceContent objectAtIndex:sourceIndexPath.row];
        [sourceContent removeObject:temp];
        
        CHXArrayDataSourceSectionItem *destinationItem = self.items[destinationIndexPath.section];
        NSMutableArray *destinationContent = [destinationItem.content mutableCopy];
        [destinationContent insertObject:temp atIndex:destinationIndexPath.row];
        
        destinationItem.content = [NSArray arrayWithArray:destinationContent];
    }
    
    sourceItem.content = [NSArray arrayWithArray:sourceContent];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self pr_numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self pr_numberOfRowsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = self.cellReuseIdentifierForIndexPath(indexPath);
    NSParameterAssert(identifier);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    id item = [self pr_itemAtIndexPath:indexPath];
    
    self.configureCellBlock(cell, item);
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (!self.collectionSupplementaryElementReuseIdentifierForIndexPath) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kNoneCollectionSectionHeaderIdentifier];
            [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kNoneCollectionSectionFooterIdentifier];
        });
        
        UICollectionReusableView *collectionReusableView = nil;
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kNoneCollectionSectionHeaderIdentifier forIndexPath:indexPath];
        } else {
            collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kNoneCollectionSectionFooterIdentifier forIndexPath:indexPath];
        }
        return collectionReusableView;
    }
    
    NSString *identifier = self.collectionSupplementaryElementReuseIdentifierForIndexPath(indexPath, kind);
    UICollectionReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    
    id item = [self pr_supplementaryElementItemAtIndexPath:indexPath ofKind:kind];
    
    if (self.configureSupplementaryElementBlock) {
        self.configureSupplementaryElementBlock(collectionReusableView, item);
    }
    
    return collectionReusableView;
}

#pragma mark - Private

- (NSInteger)pr_numberOfSections {
    return self.items.count;
}

- (NSInteger)pr_numberOfRowsInSection:(NSInteger)section {
    id item = self.items[section];
    NSParameterAssert([item isKindOfClass:NSClassFromString(@"CHXArrayDataSourceSectionItem")]);
    
    return [[item content] count];
}

- (id)pr_itemAtIndexPath:(NSIndexPath *)indexPath {
    id item = self.items[indexPath.section];
    NSParameterAssert([item isKindOfClass:NSClassFromString(@"CHXArrayDataSourceSectionItem")]);
    
    return [item content][indexPath.row];
}

- (id)pr_supplementaryElementItemAtIndexPath:(NSIndexPath *)indexPath ofKind:(NSString *)kind {
    id item = self.items[indexPath.section];
    NSParameterAssert([item class] == NSClassFromString(@"CHXArrayDataSourceCollecionViewSectionItem"));
    
    id returnValue = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        returnValue = [item supplementaryElementForHeader];
    } else {
        returnValue = [item supplementaryElementForFooter];
    }
    
    return returnValue;
}


@end

