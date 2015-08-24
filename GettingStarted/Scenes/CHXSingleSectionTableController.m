//
//  CHXSingleSectionTableController.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-31.
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

#import "CHXSingleSectionTableController.h"
#import "CHXArrayDataSource.h"

@interface CHXSingleSectionTableController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CHXArrayDataSource *arrayDataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CHXSingleSectionTableController

- (NSArray *)dataArray {
    if (!_dataArray) {
        CHXArrayDataSourceSectionItem *item1 = [[CHXArrayDataSourceSectionItem alloc] initWithContent:@[@"11", @"12"]];
        _dataArray = [@[item1] mutableCopy];
    }
    
    return _dataArray;
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customUserInterface];
}

- (void)customUserInterface {
    self.arrayDataSource = [[CHXArrayDataSource alloc] initWithDataSourceType:CHXDataSourceTypeSingleSection dataArray:self.dataArray cellReuseIdentifierForIndexPath:^NSString *(NSIndexPath *indexPath) {
        return @"SingleCell";
    } cellConfigureBlock:^(UITableViewCell *cell, id item) {
        cell.textLabel.text = item;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
    }];
    
    self.arrayDataSource.canEditRowAtIndexPath = ^BOOL (NSIndexPath *indexPath) {
        return YES;
    };
    self.arrayDataSource.commitEditingForRowAtIndexPath = ^(UITableViewCellEditingStyle editingStyle, CHXArrayDataSourceSectionItem *item) {
        
    };
    
    self.tableView.dataSource = self.arrayDataSource;
    //	self.tableView.editing = YES;
    self.tableView.delegate = self;
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}




@end
