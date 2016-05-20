//
//  IOHomeViewController.m
//  iOrder
//
//  Created by 易无解 on 4/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOHomeViewController.h"

#import "UIBarButtonItem+IOBarButtonItem.h"
#import "IOShopViewController.h"

#import "IOHomeCell.h"
#import "IOHomeHeaderView.h"

#import "YWJShopsTool.h"
#import "IOShop.h"

#import "MJRefresh.h"

@interface IOHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic, weak) IOHomeHeaderView *homeHeaderView;

@end

@implementation IOHomeViewController

#pragma mark - privacy

- (NSMutableArray *)shops {
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationView];
    
    _shops = [self shops];
    
    [self loadShopInfos];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    //    设置行高
    self.tableView.rowHeight = 70;
    
    IOHomeHeaderView *homeHeaderView = [[IOHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 305)];
    _homeHeaderView = homeHeaderView;
    self.tableView.tableHeaderView = homeHeaderView;
}

- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
//    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
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
    IOHomeCell *cell = [IOHomeCell cellWithTableView:tableView];
    
    IOShop *info = self.shops[indexPath.row];
    cell.shop = info;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IOShopViewController *shopVc = [[IOShopViewController alloc] init];
    int shopId = (int)(indexPath.row);
    shopVc.shopInfo = self.shops[shopId];
    
    shopVc.shopId = shopId + 1;
    [self.navigationController pushViewController:shopVc animated:YES];
}

#pragma mark - custom method

- (void)setupNavigationView {
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    UIBarButtonItem *locatingBtn = [UIBarButtonItem initWithNormalImage:@"address_icon" target:self action:@selector(locatingBtnClick:) width:15 height:20];
    UIBarButtonItem *locatingLabel = [UIBarButtonItem initWithtitleColor:[UIColor whiteColor] target:self action:@selector(locatingBtnClick:) title:@"定位"];
    self.navigationItem.rightBarButtonItems = @[locatingBtn, locatingLabel];
    
    UIView *locationView = [[UIView alloc] init];
    locationView.frame = CGRectMake(0, 0, 54, 18);
    UILabel *locationName = [[UILabel alloc] init];
    locationName.font = [UIFont systemFontOfSize:13];
    locationName.text = @"温江区";
    locationName.textColor = [UIColor whiteColor];
    [locationName sizeToFit];
    [locationView addSubview:locationName];
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationView.width - 10, 8, 12, 8)];
    [arrowImageView setImage:[UIImage imageNamed:@"arrows_icon"]];
    [locationView addSubview:arrowImageView];
    UIBarButtonItem *locationBarItem = [[UIBarButtonItem alloc] initWithCustomView:locationView];
    self.navigationItem.leftBarButtonItem = locationBarItem;
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 241, 28)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = 14;
    searchView.layer.masksToBounds = YES;
    
    UIImageView *searchImg = [[UIImageView alloc] init];
    
    self.navigationItem.titleView = searchView;
}

- (void)loadShopInfos {
    [YWJShopsTool newShopsSuccess:^(NSArray *shops) {
        [_shops addObjectsFromArray:shops];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        YWJLog(@"%@", error);
    }];
}

- (void)locatingBtnClick:(UIButton *)btn {
    
}

@end
