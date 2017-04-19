//
//  IOShopViewController.m
//  iOrder
//
//  Created by 易无解 on 4/25/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IOShopViewController.h"
#import "IODishViewController.h"
#import "IOSingInViewController.h"
#import "IOSubmitViewController.h"
#import "IOShoppingCartViewController.h"
#import "IOShoppingCartAnimator.h"

#import "IOShopCell.h"

#import "IOShop.h"
#import "IODishInfo.h"
#import "IOShoppingCartView.h"
#import "IOShoppingCartInfo.h"
#import "UIBarButtonItem+IOBarButtonItem.h"
#import "IOShopHeaderView.h"
#import "YWJDoubleTableView.h"
#import "IOSegmentScrollView.h"
#import "IOShopEvaluate.h"
#import "IOShopDetail.h"
#import "IOHomeManager.h"
#import "IODishesParam.h"
#import "IODishesResult.h"
#import "IOShoppingCartParam.h"
#import "IOShoppingCartResult.h"
#import "MJRefresh.h"

#define kHeaderHeight 136

extern BOOL ifNeededRefreshToken;

@interface IOShopViewController ()<YWJDoubleTableViewDelegate, IOShoppingCartViewDelegate, IOSubmitViewControllerDelegate, IOshoppingCartViewControllerDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dishInfos;
@property (nonatomic, weak) NSMutableArray *subViewArray;
@property (nonatomic, strong) IOShoppingCartResult *shoppingCartInfo;

@property (nonatomic, weak) IOShopHeaderView *shopHeaderView;
@property (nonatomic, weak) YWJDoubleTableView *doubleTableView;
@property (nonatomic, weak) IOShoppingCartView *shoppingCartView;
@property (nonatomic, strong) IOShoppingCartAnimator *shoppingCartAnimator;
@property (nonatomic, assign) CGRect shoppingCartVcFrame;

@end

@implementation IOShopViewController

#pragma mark - 懒加载

- (NSArray *)dishInfos {
    if (!_dishInfos) {
        _dishInfos = [NSMutableArray array];
    }
    
    return _dishInfos;
}

#pragma mark - 系统回调函数

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    //去除导航栏下方的横线 透明
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationView];
    
    [self dishInfos];
    
    [self setupShopHeaderView];
    
    [self setupSegmentScrollView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBGI_2"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage imageNamed:@"navigationBGI_1"]];
}

#pragma mark - 设置界面相关函数

- (void)refreshView {
    //    初始化数组和加载数据
    [self dishInfos];
    [self loadDishInfosWithShopId:self.shopId];
    [self loadShoppingCartInfosWithShopId:_shopId];
}

- (void)setupSegmentScrollView {//设置SegmentScrollView及其内容
    
    NSMutableArray *subViewArray = [NSMutableArray array];
    CGRect subViewFrame = CGRectMake(0, kHeaderHeight + 44, self.view.width, self.view.height - kHeaderHeight - 44);
    
    //    1、添加点菜View
    UIView *orderView = [[UIView alloc] initWithFrame:subViewFrame];
    [subViewArray addObject:orderView];
    //    a、添加DoubleTableView
    YWJDoubleTableView *doubleTableView = [[YWJDoubleTableView alloc] initWithFrame:CGRectMake(0, 0, orderView.width, orderView.height - 54)];
    doubleTableView.delegate = self;
    _doubleTableView = doubleTableView;
    [orderView addSubview:doubleTableView];
    
    //    b、添加购物车view
    IOShoppingCartView *shoppingCartView = [[IOShoppingCartView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(doubleTableView.frame), orderView.width, 54)];
    shoppingCartView.delegate = self;
    _shoppingCartView = shoppingCartView;
    [orderView addSubview:shoppingCartView];
    
    //    2、添加商店评价界面
    IOShopEvaluate *evaluateView = [[IOShopEvaluate alloc] initWithFrame:subViewFrame];
    [subViewArray addObject:evaluateView];
    
    //    3、添加店铺详情界面
    IOShopDetail *detailView = [[IOShopDetail alloc] initWithFrame:subViewFrame];
    [subViewArray addObject:detailView];
    
    //    4、添加SegmentScrollView以便左右滑动
    IOSegmentScrollView *scrollView = [[IOSegmentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_shopHeaderView.frame), self.view.width, self.view.height - kHeaderHeight) titleArray:@[@"点菜", @"评价", @"店铺详情"] contentViewArray:subViewArray];
    [self.view addSubview:scrollView];
    
    //    5.刷新数据
    __weak typeof(self) weakSelf = self;
    doubleTableView.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (ifNeededRefreshToken) {
            [weakSelf refreshToken];
        } else {
            [weakSelf loadShopAndShoppingCartData];
        }
    }];
    [doubleTableView.rightTableView.mj_header beginRefreshing];
    
}

- (void)setupShopHeaderView {
    IOShopHeaderView *shopHeaderView = [[IOShopHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderHeight)];
    _shopHeaderView = shopHeaderView;
    shopHeaderView.shopInfo = self.shopInfo;
    [self.view addSubview:shopHeaderView];
}

- (void)setupNavigationView {
    
    UIBarButtonItem *collectBtn = [UIBarButtonItem initWithNormalImage:@"heart" target:self action:@selector(collectBtnClick) width:22 height:20];
    UIBarButtonItem *signInBtn = [UIBarButtonItem initWithNormalImage:@"calendar" target:self action:@selector(signInBtnClick) width:18 height:22];
    UIBarButtonItem *signInLabel = [UIBarButtonItem initWithtitleColor:[UIColor whiteColor] target:self action:@selector(signInLabel) title:@"签到"];
    self.navigationItem.rightBarButtonItems = @[collectBtn, signInBtn, signInLabel];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

#pragma mark - 数据请求相关函数


- (void)refreshToken {
    __weak typeof(self) weakSelf = self;
    [IOHomeManager refreshTokenSuccess: ^{
        // 刷新token并保存成功
        ifNeededRefreshToken = NO;
        
        // 开始请求数据
        [weakSelf loadShopAndShoppingCartData];
        
    } failure:^(NSError * _Nonnull error) {
        IOLog(@"%@", error);
    }];
}

- (void)loadShopAndShoppingCartData {
    [self loadDishInfosWithShopId:self.shopId];
    [self loadShoppingCartInfosWithShopId:self.shopId];
    [self.doubleTableView.rightTableView.mj_header endRefreshing];
}

- (void)loadDishInfosWithShopId:(NSInteger)shopId {
    __weak typeof(self) weakSelf = self;
    [IOHomeManager loadShopDishesWithShopId:shopId Success:^(IODishesResult * _Nullable dishesResult) {
        [weakSelf.dishInfos addObjectsFromArray:dishesResult.categories];
        weakSelf.doubleTableView.dishInfos = _dishInfos;
    } failure:^(NSError * _Nullable error) {
        IOLog(@"%@", error);
    }];
}

- (void)loadShoppingCartInfosWithShopId:(NSInteger)shopId {
    IOShoppingCartParam *param = [[IOShoppingCartParam alloc] init];
    param.shopId = shopId;
    __weak typeof(self) weakSelf = self;
    [IOHomeManager loadShoppingCartInfosWithShopId:param Success:^(IOShoppingCartResult * _Nullable result) {
        weakSelf.shoppingCartInfo = result;
        weakSelf.shoppingCartView.totalPri = result.totalPrice;
        weakSelf.shoppingCartView.badge.badgeValue = [NSString stringWithFormat:@"%ld", result.items.count];
    } failure:^(NSError * _Nullable error) {
        IOLog(@"%@", error);
    }];
}

#pragma mark - 事件监听函数

- (void)collectBtnClick {
    IOLog(@"collectBtn click");
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

#pragma mark - YWJDoubleTableViewDelegate

- (void)doubleTableView:(UIView *)doubleTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IODishViewController *dishVc = [[IODishViewController alloc] init];
    
    IODishCategory *dishes = _dishInfos[indexPath.section];
    dishVc.dishInfo = dishes.goodsList[indexPath.row];
    
    [self.navigationController pushViewController:dishVc animated:YES];
}

#pragma mark - DoubleTableViewDelegate

- (void)doubleTableView:(UIView *)doubleTableView dishPrice:(float)dishPrice clickedBtn:(UIButton *)btn {
    [self loadShoppingCartInfosWithShopId:self.shopId];
}

#pragma mark - IOShoppingCartViewDelegate
- (void)shoppingCartView:(IOShoppingCartView *)shoppingCartView checkOutBtnClick:(UIButton *)btn{
    IOSubmitViewController *submitVc = [[IOSubmitViewController alloc] init];
    submitVc.shopInfo = self.shopInfo;
    submitVc.delegate = self;
    submitVc.totalPrice = shoppingCartView.totalPrice.text;
    
    //    将doubleTableView的代理设为空
    _doubleTableView.leftTableView.delegate = nil;
    _doubleTableView.leftTableView.dataSource = nil;
    _doubleTableView.rightTableView.delegate = nil;
    _doubleTableView.rightTableView.dataSource = nil;
    
    [self.navigationController pushViewController:submitVc animated:YES];
}

- (void)shoppingCartView:(IOShoppingCartView *)shoppingCartView shoppingCartBtnClick:(UIButton *)btn {
    
    //    1.创建控制器
    IOShoppingCartViewController *shoppingCartVc = [[IOShoppingCartViewController alloc] init];
    shoppingCartVc.shoppingCartInfo = self.shoppingCartInfo;
    shoppingCartVc.delegate = self;
    
    //    2.设置控制器的modal样式
    shoppingCartVc.modalPresentationStyle = UIModalPresentationCustom;
    
    //    3.设置转场代理
    IOShoppingCartAnimator *shoppingCartAnimator = [[IOShoppingCartAnimator alloc] initWithCallBack:^(BOOL presented) {
        self.shoppingCartView.shoppingCarBtn.selected = presented;
    }];
    self.shoppingCartAnimator = shoppingCartAnimator;
    CGFloat shoppingCartHeight = self.shoppingCartInfo.items.count * 44;
    if (shoppingCartHeight > 250) {
        shoppingCartHeight = 250;
    }
    CGRect tempFrame = CGRectMake(0, IOScreenHeight - 54 - 44 - shoppingCartHeight, IOScreenWidth, shoppingCartHeight + 44);
    shoppingCartAnimator.presentedFrame = tempFrame;
    shoppingCartVc.transitioningDelegate = shoppingCartAnimator;
    
    //    4.弹出控制器
    [self.navigationController presentViewController:shoppingCartVc animated:YES completion:nil];
}

#pragma mark - IOSubmitViewControllerDelegate

- (void)submitViewController:(IOSubmitViewController *)submitVc isPaySuccessful:(BOOL)suc{
    if (suc == YES) {
        if (_dishInfos.count != 0) {
            [_dishInfos removeAllObjects];
            [_shoppingCartInfo.items removeAllObjects];
            _shoppingCartInfo.totalPrice = 0;
            [self.doubleTableView.rightTableView.mj_header beginRefreshing];
        }
    }
}

#pragma mark - IOshoppingCartViewControllerDelegate

- (void)shoppingCartViewController:(IOShoppingCartViewController *)shoppingCartVc dishItem:(IOShoppingCartItem *)item clickedBtn:(UIButton *)btn {
    [self loadShoppingCartInfosWithShopId:self.shopId];
    [self.doubleTableView.rightTableView reloadData];
}

@end
