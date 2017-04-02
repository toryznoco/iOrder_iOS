//
//  IOHomeViewController.m
//  iOrder
//
//  Created by 易无解 on 4/9/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IOHomeViewController.h"

#import "UIBarButtonItem+IOBarButtonItem.h"
#import "IOShopViewController.h"

#import "IOHomeCell.h"
#import "IOHomeHeaderView.h"

#import "IOShop.h"

#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "IOHomeManager.h"

extern BOOL ifNeededRefreshToken;

@interface IOHomeViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *nearbyShops;
@property (nonatomic, weak) IOHomeHeaderView *homeHeaderView;

@end

@implementation IOHomeViewController

#pragma mark - 懒加载属性

- (NSMutableArray *)nearbyShops {
    if (!_nearbyShops) {
        _nearbyShops = @[].mutableCopy;
    }
    return _nearbyShops;
}

#pragma mark - 系统回调函数

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:kIOThemeColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (ifNeededRefreshToken) {
            [self refreshToken];
        } else {
            [self loadNearbyShops];
        }
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置行高
    self.tableView.rowHeight = 70;
    
    IOHomeHeaderView *homeHeaderView = [[IOHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 280)];
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

#pragma mark - 设置界面相关函数

- (void)setupProgressView {
    //    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    UIView *mask = [[UIView alloc] initWithFrame:self.view.frame];
    //    mask.center = CGPointMake(self.view.center.x, 150);
    mask.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mask];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mask animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [[UIImage imageNamed:@"success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.label.text = NSLocalizedString(@"Login Successed", @"HUD done title");
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [mask removeFromSuperview];
    //    });
    //    [hud hide:YES afterDelay:1.0];
}

- (void)setupNavigationView {
    [self.navigationController.navigationBar setBarTintColor:kIOThemeColor];
    
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

#pragma mark - 数据请求相关函数

- (void)refreshToken {
    
    [IOHomeManager refreshTokenSuccess: ^{
        // 刷新token并保存成功
        ifNeededRefreshToken = NO;
        
        // 开始请求数据
        [self loadNearbyShops];
        
    } failure:^(NSError * _Nonnull error) {
        IOLog(@"%@", error);
    }];
}

- (void)loadNearbyShops {
    [IOHomeManager loadNearbyShopsSuccess:^(NSArray *nearbyShops) {
        if (self.nearbyShops.count < nearbyShops.count) {
            self.nearbyShops = nearbyShops.mutableCopy;
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        IOLog(@"%@", error);
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 事件监听函数

- (void)locatingBtnClick:(UIButton *)btn {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nearbyShops.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IOHomeCell *cell = [IOHomeCell cellWithTableView:tableView];
    
    IOShop *info = self.nearbyShops[indexPath.row];
    cell.shop = info;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    IOHomeCellHeaderView *tableViewHeaderView = [[IOHomeCellHeaderView alloc] init];
    return tableViewHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IOShopViewController *shopVc = [[IOShopViewController alloc] init];
//    int shopId = (int)(indexPath.row);
    shopVc.shopInfo = self.nearbyShops[indexPath.row];
    IOShop *shop = self.nearbyShops[indexPath.row];
    shopVc.shopId = shop.shopId;
    
    [self.navigationController pushViewController:shopVc animated:YES];
}

#pragma mark - UIScrollViewDelegate
//  收起键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.navigationItem.titleView endEditing:YES];
}


@end
