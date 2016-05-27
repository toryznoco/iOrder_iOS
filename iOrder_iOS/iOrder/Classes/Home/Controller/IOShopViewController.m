//
//  IOShopViewController.m
//  iOrder
//
//  Created by 易无解 on 4/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShopViewController.h"
#import "IODishViewController.h"
#import "IOSingInViewController.h"
#import "IOSubmitViewController.h"

#import "IOShopCell.h"

#import "IOShop.h"
#import "IODishInfo.h"
#import "IOShoppingCartView.h"
#import "YWJDishesTool.h"
#import "UIBarButtonItem+IOBarButtonItem.h"
#import "IOShopHeaderView.h"
#import "YWJDoubleTableView.h"
#import "IOShopOptionView.h"

#define kHeaderHeight 136

@interface IOShopViewController ()<YWJDoubleTableViewDelegate, IOShoppingCartViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dishInfos;

@property (nonatomic, weak) IOShopHeaderView *shopHeaderView;
@property (nonatomic, weak) IOShopOptionView *shopOptionView;
@property (nonatomic, weak) YWJDoubleTableView *doubleTableView;
@property (nonatomic, weak) IOShoppingCartView *shoppingCartView;

@end

@implementation IOShopViewController

#pragma mark - privacy

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_dishInfos.count != 0) {
        YWJLog(@"%ld", _dishInfos.count);
        [_dishInfos removeAllObjects];
        [self refreshView];
        YWJLog(@"%ld", _dishInfos.count);
    }
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;

    //去除导航栏下方的横线 透明
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBGI_2"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage imageNamed:@"navigationBGI_1"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YWJDoubleTableViewDelegate

- (void)doubleTableView:(UIView *)doubleTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IODishViewController *dishVc = [[IODishViewController alloc] init];
    
    IODishes *dishes = _dishInfos[indexPath.section];
    dishVc.dishInfo = dishes.dishes[indexPath.row];
    
    [self.navigationController pushViewController:dishVc animated:YES];
}

#pragma mark - custom methods

- (void)refreshView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    初始化数组和加载数据
    [self dishInfos];
    [self loadDishInfosWithShopId:self.shopId];
    
    [self setupNavigationItem];
    
    [self setupShopHeaderView];
    
    [self setupOptionView];
    
    [self setupDoubleTableView];
    
    [self setUpShoppingCartView];
}

- (void)setupDoubleTableView {
    YWJDoubleTableView *doubleTableView = [[YWJDoubleTableView alloc] initWithFrame:CGRectMake(0, kHeaderHeight + 40, self.view.width, self.view.height - kHeaderHeight - 44 - 40)];
    doubleTableView.delegate = self;
    _doubleTableView = doubleTableView;
    [self.view addSubview:doubleTableView];
}

- (void)setupShopHeaderView {
    IOShopHeaderView *shopHeaderView = [[IOShopHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderHeight)];
    _shopHeaderView = shopHeaderView;
    shopHeaderView.shopInfo = self.shopInfo;
    [self.view addSubview:shopHeaderView];
}

- (void)setupOptionView {
    IOShopOptionView *shopOptionView = [[IOShopOptionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_shopHeaderView.frame), self.view.width, 40)];
    _shopOptionView = shopOptionView;
    [self.view addSubview:shopOptionView];
}

- (void)setupNavigationItem {
    
    UIBarButtonItem *collectBtn = [UIBarButtonItem initWithNormalImage:@"heart" target:self action:@selector(collectBtnClick) width:22 height:20];
    UIBarButtonItem *signInBtn = [UIBarButtonItem initWithNormalImage:@"calendar" target:self action:@selector(signInBtnClick) width:18 height:22];
    UIBarButtonItem *signInLabel = [UIBarButtonItem initWithtitleColor:[UIColor whiteColor] target:self action:@selector(signInLabel) title:@"签到"];
    self.navigationItem.rightBarButtonItems = @[collectBtn, signInBtn, signInLabel];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
//    UIBarButtonItem *backItem = [UIBarButtonItem initWithNormalImage:@"arrow" target:self action:@selector(backBtnClick) width:12 height:21];
//    self.navigationItem.leftBarButtonItem = backItem;
}

- (NSMutableArray *)dishInfos {
    if (!_dishInfos) {
        _dishInfos = [NSMutableArray array];
    }
    return _dishInfos;
}

- (void)loadDishInfosWithShopId:(int)shopId {
    [YWJDishesTool newShopDishesWithShopId:shopId Success:^(NSArray *shops) {
        NSMutableArray *dishInfosArray = [NSMutableArray array];
        for (NSDictionary *dishInfoDic in shops) {
            IODishes *dishes = [IODishes mj_objectWithKeyValues:dishInfoDic];
            NSMutableArray *dishArray = [NSMutableArray array];
            for (NSDictionary *dishDic in dishes.dishes) {
                IODish *dish = [IODish mj_objectWithKeyValues:dishDic];
                [dishArray addObject:dish];
            }
            dishes.dishes = dishArray;
            [dishInfosArray addObject:dishes];
        }
        
        [_dishInfos addObjectsFromArray:dishInfosArray];
        _doubleTableView.dishInfos = _dishInfos;
    } failure:^(NSError *error) {
        YWJLog(@"%@", error);
    }];
}

/**
 *  购物栏的View
 */
- (void)setUpShoppingCartView {
    IOShoppingCartView *shoppingCartView = [[IOShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.height - 54, self.view.width, 54)];
    shoppingCartView.delegate = self;
    _shoppingCartView = shoppingCartView;
    [self.view addSubview:shoppingCartView];
}

- (void)collectBtnClick {
    YWJLog(@"collectBtn click");
}

- (void)signInBtnClick {
    IOSingInViewController *signInVc = [[IOSingInViewController alloc] init];
    [self.navigationController pushViewController:signInVc animated:YES];
}

- (void)signInLabel {
    
}

//- (void)backBtnClick {
//    [self.navigationController popViewControllerAnimated:YES];
//}

#pragma mark - DoubleTableViewDelegate

- (void)doubleTableView:(UIView *)doubleTableView dishPrice:(float)dishPrice clickedBtn:(UIButton *)btn {
    if (btn.tag == 1) {
                _shoppingCartView.checkOutView.backgroundColor = [UIColor orangeColor];
                _shoppingCartView.shoppingCarBtn.enabled = YES;
                _shoppingCartView.totalPrice.textColor = [UIColor greenColor];
                if ([_shoppingCartView.totalPrice.text isEqualToString:@"购物车是空的"]) {
                    _shoppingCartView.totalPrice.text = @"0.00";
                    _shoppingCartView.checkOutBtn.enabled = YES;
                }
                _shoppingCartView.badge.badgeValue = [NSString stringWithFormat:@"%lld", [_shoppingCartView.badge.badgeValue longLongValue] + 1];
                _shoppingCartView.totalPrice.text = [NSString stringWithFormat:@"¥ %.2f", ([[_shoppingCartView.totalPrice.text substringFromIndex:1] floatValue] + dishPrice)];
    } else {
                _shoppingCartView.badge.badgeValue = [NSString stringWithFormat:@"%lld", [_shoppingCartView.badge.badgeValue longLongValue] - 1];
                _shoppingCartView.totalPrice.text = [NSString stringWithFormat:@"¥ %.2f", ([[_shoppingCartView.totalPrice.text substringFromIndex:1] floatValue] - dishPrice)];
                if ([_shoppingCartView.totalPrice.text isEqualToString:@"¥ 0.00"]) {
                    _shoppingCartView.checkOutBtn.enabled = NO;
                    _shoppingCartView.checkOutView.backgroundColor = [UIColor lightGrayColor];
                    _shoppingCartView.shoppingCarBtn.enabled = NO;
                    _shoppingCartView.totalPrice.textColor = [UIColor lightGrayColor];
                    _shoppingCartView.totalPrice.text = @"购物车是空的";
                }
    }
}

#pragma mark - IOShoppingCartViewDelegate
- (void)shoppingCartView:(IOShoppingCartView *)shoppingCartView checkOutBtnClick:(UIButton *)btn{
    IOSubmitViewController *submitVc = [[IOSubmitViewController alloc] init];
    submitVc.shopInfo = self.shopInfo;
    submitVc.totalPrice = shoppingCartView.totalPrice.text;
    [self.navigationController pushViewController:submitVc animated:YES];
}

@end
