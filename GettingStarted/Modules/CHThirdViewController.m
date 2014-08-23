//
//  CHThirdViewController.m
//  GettingStarted
//
//  Created by Moch on 8/23/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "CHThirdViewController.h"
#import "SVPullToRefresh.h"

@interface CHThirdViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

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
    [self initialDatas];
    [self initialTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialDatas {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        for (int i = 0; i < 10; i++) {
            [_dataArray addObject:[NSString stringWithFormat:@"origin data: %d", i]];
        }
    }
}


- (void)initialTableView {
    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    
    [self.tableView reloadData];
}

- (void)insertRowAtTop {
    static int count = 0;
    for (int i = 0; i < 4; i++) {
        [_dataArray insertObject:[NSString stringWithFormat:@"insert row at top: %d", count++] atIndex:0];
    }
    [self.tableView reloadData];
    [self.tableView.pullToRefreshView stopAnimating];
}

- (void)insertRowAtBottom {
    __weak typeof(self) weakSelf = self;
    static int count = 0;
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (int i = 0; i < 4; i ++) {
        [_dataArray addObject:[NSString stringWithFormat:@"insert row at top: %d", count++]];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0];
        [indexPaths addObject:indexPath];
    }
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [weakSelf.tableView endUpdates];
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"dddd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

@end
