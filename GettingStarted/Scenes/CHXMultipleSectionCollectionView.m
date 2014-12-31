//
//  CHXMultipleSectionCollectionView.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-31.
//	Copyright (c) 2014 Moch Xiao (htt://github.com/atcuan).
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import "CHXMultipleSectionCollectionView.h"
#import "CHXArrayDataSource.h"

@interface CHXMultipleSectionCollectionView () <UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) CHXArrayDataSource *arrayDataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@class CHXCollectionReusableViewPrototype;

@implementation CHXMultipleSectionCollectionView

#pragma mark -

- (NSMutableArray *)dataArray {
	if (!_dataArray) {
		NSArray *content = @[@"1", @"2", @"3", @"4"];
		CHXArrayDataSourceCollecionViewSectionItem *item1 = [[CHXArrayDataSourceCollecionViewSectionItem alloc] initWithContent:content supplementaryElementForHeader:@"header one" supplementaryElementForFooter:@"footer one"];
		CHXArrayDataSourceCollecionViewSectionItem *item2 = [[CHXArrayDataSourceCollecionViewSectionItem alloc] initWithContent:content supplementaryElementForHeader:@"Feader Two" supplementaryElementForFooter:@"Footer Two"];
		_dataArray = [@[item1, item2] mutableCopy];
	}
	
	return _dataArray;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self customUserInterface];
}

- (void)customUserInterface {
	self.arrayDataSource = [[CHXArrayDataSource alloc] initWithDataSourceType:CHXDataSourceTypeMultipleSection dataArray:self.dataArray cellReuseIdentifierForIndexPath:^NSString *(NSIndexPath *indexPath) {
		return @"CollectionCell";
	} cellConfigureBlock:^(UICollectionViewCell *cell, id item) {
		cell.backgroundColor = [UIColor orangeColor];
	}];

	self.arrayDataSource.collectionSupplementaryElementReuseIdentifierForIndexPath = ^NSString *((NSIndexPath *indexPath, NSString *kind)) {
		if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
			return @"CollectionReuseFooterView";
		}
		
		return @"CollectionReuseHeaderView";
	};
	self.arrayDataSource.configureSupplementaryElementBlock = ^(UICollectionReusableView *view, id item) {
		NSLog(@"%@", item);
	};

	self.collectionView.dataSource = self.arrayDataSource;
}

#pragma mark -

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake((collectionView.bounds.size.width - 30) / 2, collectionView.bounds.size.width / 2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(25, 10, 20, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
	return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 10;
}

@end
