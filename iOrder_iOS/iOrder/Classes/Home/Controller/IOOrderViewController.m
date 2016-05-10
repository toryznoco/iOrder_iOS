//
//  IOOrderViewController.m
//  iOrder
//
//  Created by 易无解 on 4/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOOrderViewController.h"

#import "IOShopViewController.h"

#import "IOOrderHeaderView.h"
#import "IOOrderViewCell.h"

#import "YWJShopsTool.h"
#import "IOShop.h"

#import "MJRefresh.h"

@interface IOOrderViewController ()<UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *shops;

@end

@implementation IOOrderViewController

#pragma mark - privacy

- (NSMutableArray *)shops{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shops = [self shops];
    
    [self loadShopInfos];
    
    self.title = @"Order";
    self.view.backgroundColor = [UIColor whiteColor];
    //    设置行高
    self.tableView.rowHeight = 70;
    
    self.tableView.tableHeaderView = [[IOOrderHeaderView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shops.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IOOrderViewCell *cell = [IOOrderViewCell cellWithTableView:tableView];
    
    IOShop *info = self.shops[indexPath.row];
    cell.shop = info;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IOShopViewController *shopVc = [[IOShopViewController alloc] init];
    
    [self.navigationController pushViewController:shopVc animated:YES];
}

#pragma mark - custom method

- (void)loadShopInfos{
    [YWJShopsTool newShopsSuccess:^(NSArray *shops) {
        [_shops addObjectsFromArray:shops];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        YWJLog(@"%@", error);
    }];
}

@end
