//
//  CHThirdViewController.m
//  GettingStarted
//
//  Created by Moch on 8/23/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CHThirdViewController.h"
#import "UIScrollView+RefreshControl.h"
#import "MakeDataSourceBetter.h"

@interface CHThirdViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) MakeDataSourceBetter *arraryDataSource;

@end

@implementation CHThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataSource = [[NSMutableArray alloc] init];
    
    _arraryDataSource = [[MakeDataSourceBetter alloc] initWithCellIdentifier:@"cell"
                                                                  items:_dataSource
                                                     cellConfigureBlock:^(UITableViewCell *cell, id item) {
        cell.textLabel.text = item;
    }];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    self.tableView.dataSource = _arraryDataSource;
    
    for (int i = 0; i < 19; i++) {
        NSString *data = [NSString stringWithFormat:@"initial data number: %d", i];
        [_dataSource addObject:data];
    }
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addTopRefreshControlUsingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i = 0; i < 5; i++) {
                NSString *data = [NSString stringWithFormat:@"pull down data random number: %d", arc4random() % 100];
                [weakSelf.dataSource insertObject:data atIndex:0];
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView topRefreshControlStopRefreshing];
        });
    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeTextAndArrow];
    
    [self.tableView addBottomRefreshControlUsingBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i = 0; i < 5; i++) {
                NSString *data = [NSString stringWithFormat:@"pull up data random number: %d", arc4random() % 100];
                [weakSelf.dataSource addObject:data];
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView bottomRefreshControlStopRefreshing];
            
        });
    } refreshControlPullType:RefreshControlPullTypeInsensitive refreshControlStatusType:RefreshControlStatusTypeTextAndArrow];
    
    //    self.tableView.topRefreshControlPullToRefreshingText = @"下拉刷新";
    //    self.tableView.statusTextColor = [UIColor redColor];
    //    self.tableView.loadingCircleColor = [UIColor orangeColor];
}

@end
