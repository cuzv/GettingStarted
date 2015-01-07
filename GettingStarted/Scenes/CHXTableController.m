//
//  CHXTableController.m
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

#import "CHXTableController.h"
#import "CHXArrayDataSource.h"

@interface CHXTableController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CHXArrayDataSource *arrayDataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath *currentInsertIndexPath;



@end

@implementation CHXTableController

#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self customUserInterface];
}

- (NSMutableArray *)dataArray {
	if (!_dataArray) {
		CHXArrayDataSourceSectionItem *item1 = [[CHXArrayDataSourceTableViewSectionItem alloc] initWithContent:@[@"11", @"12"] titleForHeader:@"Section 1 header" titleForFooter:@"Section 1 footer" indexTitle:@"1"];
		CHXArrayDataSourceSectionItem *item2 = [[CHXArrayDataSourceTableViewSectionItem alloc] initWithContent:@[@"21", @"22", @"23"] titleForHeader:@"Section 1 header" titleForFooter:@"Section 1 footer" indexTitle:@"2"];
		CHXArrayDataSourceSectionItem *item3 = [[CHXArrayDataSourceTableViewSectionItem alloc] initWithContent:@[@"31"] titleForHeader:@"Section 1 header" titleForFooter:@"Section 1 footer" indexTitle:@"3"];
		_dataArray = [@[item1, item2, item3, item1, item2, item3, item1, item2, item3, item1, item2, item3] mutableCopy];
	}
	
	return _dataArray;	
}

- (void)customUserInterface {
	__weak typeof(self) weakSelf = self;
	self.arrayDataSource = [[CHXArrayDataSource alloc] initWithDataSourceType:CHXDataSourceTypeMultipleSection dataArray:self.dataArray cellReuseIdentifierForIndexPath:^NSString *(NSIndexPath *indexPath) {
		if ([indexPath isEqual:weakSelf.currentInsertIndexPath]) {
			return @"InsertCell";
		}
		
		return @"Cell";
	} cellConfigureBlock:^(UITableViewCell *cell, id item) {
		if (![cell.reuseIdentifier isEqualToString:@"InsertCell"]) {
			cell.textLabel.text = item;
		}
	}];
	self.arrayDataSource.canEditRowAtIndexPath = ^BOOL (NSIndexPath *indexPath) {
		return YES;
	};
	self.arrayDataSource.commitEditingForRowAtIndexPath = ^(UITableViewCellEditingStyle editingStyle, CHXArrayDataSourceSectionItem *item) {
		
	};
	self.arrayDataSource.currentInsertRowAtIndexPath = ^(NSIndexPath *indexPahth) {
		weakSelf.currentInsertIndexPath = indexPahth;
	};
	
	self.tableView.dataSource = self.arrayDataSource;
	self.tableView.delegate = self;
//	self.tableView.editing = YES;
}

#pragma mark -

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	NSLog(@"cell frame = %@", NSStringFromCGRect(cell.frame));
	
	CGRect convertFrame = [cell convertRect:cell.contentView.frame toView:self.view];
	NSLog(@"convertFrame = %@", NSStringFromCGRect(convertFrame));
}

@end
