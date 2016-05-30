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

@interface IOHomeViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

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
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _shops = [self shops];
        
        [self loadShopInfos];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    //    设置行高
    self.tableView.rowHeight = 70;
    
    IOHomeHeaderView *homeHeaderView = [[IOHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 305)];
    _homeHeaderView = homeHeaderView;
    self.tableView.tableHeaderView = homeHeaderView;
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
    IOShop *shop = self.shops[shopId];
    shopVc.shopId = shop.shopId;
    
    [self.navigationController pushViewController:shopVc animated:YES];
}

#pragma mark - UIScrollViewDelegate
//  收起键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.navigationItem.titleView endEditing:YES];
}

#pragma mark - custom method

- (void)setupNavigationView {
    [self.navigationController.navigationBar setBarTintColor:kIOThemeColors];
    UIBarButtonItem *locatingBtn = [UIBarButtonItem initWithNormalImage:@"address_icon" target:self action:@selector(locatingBtnClick:) width:15 height:20];
    UIBarButtonItem *locatingLabel = [UIBarButtonItem initWithtitleColor:[UIColor whiteColor] target:self action:@selector(locatingBtnClick:) title:@"定位"];
    self.navigationItem.rightBarButtonItems = @[locatingBtn, locatingLabel];
    
    UIView *locationView = [[UIView alloc] init];
    locationView.frame = CGRectMake(0, 0, 54, 18);
    UILabel *locationName = [[UILabel alloc] init];
    locationName.font = [UIFont systemFontOfSize:13];
    locationName.text = @"都江堰";
    locationName.textColor = [UIColor whiteColor];
    [locationName sizeToFit];
    [locationView addSubview:locationName];
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(locationView.width - 10, 8, 12, 8)];
    [arrowImageView setImage:[UIImage imageNamed:@"arrows_icon"]];
    [locationView addSubview:arrowImageView];
    UIBarButtonItem *locationBarItem = [[UIBarButtonItem alloc] initWithCustomView:locationView];
    self.navigationItem.leftBarButtonItem = locationBarItem;
    
    CGFloat searchViewW = 2 * (self.view.width - CGRectGetMaxX(locationView.frame) - 20);
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, searchViewW, 28)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = 14;
    searchView.layer.masksToBounds = YES;
    
    UIImageView *searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 15, 15)];
    [searchImg setImage:[UIImage imageNamed:@"select-icon"]];
    [searchView addSubview:searchImg];
    
    CGFloat textW = searchView.width - 7 - searchImg.width - 10;
    CGFloat textH = 15;
    CGFloat textX = CGRectGetMaxX(searchImg.frame) + 10;
    CGFloat textY = searchImg.y + 2;
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(textX, textY, textW, textH)];
    searchTextField.placeholder = @"输入商家、品类";
    searchTextField.font = [UIFont systemFontOfSize:13];
    [searchView addSubview:searchTextField];
    
    self.navigationItem.titleView = searchView;
}

- (void)loadShopInfos {
    [YWJShopsTool newShopsSuccess:^(NSArray *shops) {
        if (_shops.count < shops.count) {
            [_shops addObjectsFromArray:shops];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        YWJLog(@"%@", error);
    }];
}

- (void)locatingBtnClick:(UIButton *)btn {
    
}

@end
