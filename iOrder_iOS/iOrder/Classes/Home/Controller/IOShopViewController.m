//
//  IOShopViewController.m
//  iOrder
//
//  Created by 易无解 on 4/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOShopViewController.h"

#import "IODishViewController.h"
#import "IOHomeShopCell.h"

#import "IODishInfo.h"
#import "IOShoppingView.h"
#import "YWJDishesTool.h"
#import "UIBarButtonItem+IOBarButtonItem.h"
#import "IOHomeShopHeaderView.h"

#define kScale 0.25
#define kHeaderHeight 156

@interface IOShopViewController ()<UITableViewDataSource, UITableViewDelegate, IOHomeShopMenuCellDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL isRelate;

@property (nonatomic, weak) UIView *tableView;
@property (nonatomic, strong) UITableView *optionTableView;
@property (nonatomic, strong) UITableView *menuTableView;

@property (nonatomic, strong) NSMutableArray *dishInfos;

@property (nonatomic, weak) IOShoppingView *shoppingView;

@end

@implementation IOShopViewController

#pragma mark - privacy

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    初始化数组和加载数据
    [self dishInfos];
    [self loadDishInfosWithShopId:self.shopId];
    
    [self setupNavigationItem];
    
    [self setupShopHeaderView];
    
    [self setupSelfView];
    
    [self setupTableView];
    
    [self setUpShoppingView];
    
    _isRelate = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    //去除导航栏下方的横线 透明
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.optionTableView) {
        return 1;
    }else{
        return _dishInfos.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    IODishes *dishInfo = _dishInfos[section];
    if (tableView == self.optionTableView) {
        return _dishInfos.count;
    }else{
        return dishInfo.dishes.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == self.optionTableView) {
        cell = [IOHomeShopOptionCell cellWithTableView:tableView];
        
        IODishes *dishInfo = _dishInfos[indexPath.row];
        
        ((IOHomeShopOptionCell *)cell).category = dishInfo.catgName;
    }else{
        cell = [IOHomeShopMenuCell cellWithTableView:tableView];
        ((IOHomeShopMenuCell *)cell).delegate = self;
        
        IODishes *dishInfo = _dishInfos[indexPath.section];
        IODish *dish = dishInfo.dishes[indexPath.row];
        
        ((IOHomeShopMenuCell *)cell).dish = dish;
    }
    
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.optionTableView) {
        return 51;
    }else{
        return 68;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.optionTableView) {
        return 0;
    }else{
        return 22;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.optionTableView) {
        return 0;
    }else{
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.menuTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 22)];
        view.backgroundColor = YWJRGBColor(217, 217, 217, 0.7);
        
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        IODishes *dishInfo = _dishInfos[section];
        label.text = [NSString stringWithFormat:@"   %@", dishInfo.catgName];
        label.textColor = YWJRGBColor(88, 88, 88, 1);
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        
        return view;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (_isRelate) {
//      获得一个UITableView的可见部分的第一个cell， 然后算出它属于哪个组
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == self.menuTableView) {
            [self.optionTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == self.menuTableView) {
            [self.optionTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.optionTableView) {
        _isRelate = NO;
        [self.optionTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [self.menuTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [self.menuTableView deselectRowAtIndexPath:indexPath animated:NO];
        
        IODishViewController *dishVc = [[IODishViewController alloc] init];
        [self.navigationController pushViewController:dishVc animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _isRelate = YES;
}

#pragma mark - custom methods

- (void)setupTableView{
    UIView *tableView = [[UIView alloc] initWithFrame:CGRectMake(0, 156, self.view.width, self.view.height - 156 - 44)];
    _tableView = tableView;
    [self.view addSubview:tableView];
    
    [self optionTableView];
    
    [self menuTableView];
}

- (void)setupShopHeaderView{
    IOHomeShopHeaderView *shopHeaderView = [[IOHomeShopHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderHeight)];
    [self.view addSubview:shopHeaderView];
}

- (void)setupNavigationItem{
    
    UIBarButtonItem *collectBtn = [UIBarButtonItem initWithNormalImage:@"heart" target:self action:@selector(collectBtnClick) width:16 height:14];
    UIBarButtonItem *signInBtn = [UIBarButtonItem initWithNormalImage:@"calender" target:self action:@selector(signInBtnClick) width:16 height:14];
    UIBarButtonItem *signInLabel = [UIBarButtonItem initWithtitleColor:[UIColor orangeColor] target:self action:@selector(signInLabel) title:@"签到"];
    self.navigationItem.rightBarButtonItems = @[collectBtn, signInBtn, signInLabel];
    
    UIBarButtonItem *backBtn = [UIBarButtonItem initWithNormalImage:@"arrow" target:self action:@selector(backBtnClick) width:12 height:21];
    self.navigationItem.leftBarButtonItem = backBtn;
}

- (NSMutableArray *)dishInfos{
    if (!_dishInfos) {
        _dishInfos = [NSMutableArray array];
    }
    return _dishInfos;
}

- (void)loadDishInfosWithShopId:(int)shopId{
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
        _optionTableView.dataSource = self;
        _optionTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.delegate = self;
        [_menuTableView reloadData];
        [_optionTableView reloadData];
    } failure:^(NSError *error) {
        YWJLog(@"%@", error);
    }];
}

- (UITableView *)optionTableView{
    if (!_optionTableView) {
        _optionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * kScale, self.tableView.height)];
        _optionTableView.backgroundColor = [UIColor whiteColor];
        [self.tableView addSubview:_optionTableView];
    }
    return _optionTableView;
}

- (UITableView *)menuTableView{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.width * kScale, 0, self.view.width * (1 - kScale), self.tableView.height)];
        _menuTableView.backgroundColor = [UIColor whiteColor];
        [self.tableView addSubview:_menuTableView];
    }
    return _menuTableView;
}

/**
 *  购物栏的View
 */
- (void)setUpShoppingView{
    IOShoppingView *shoppingView = [[IOShoppingView alloc] initWithFrame:CGRectMake(0, self.view.height - 54, self.view.width, 54)];
    [self.view addSubview:shoppingView];
    _shoppingView = shoppingView;
}

- (void)setupSelfView{
//    布局就是从导航栏下面开始
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    CGRect viewBounds = self.view.bounds;
//    float navBarH = self.navigationController.navigationBar.height + 20;
//    viewBounds.size.height = YWJMainScreenBounds.size.height - navBarH;
//    self.view.bounds = viewBounds;
}

- (void)collectBtnClick{
    YWJLog(@"collectBtn click");
}

- (void)signInBtnClick{
    YWJLog(@"signInBtn click");
}

- (void)signInLabel{
    
}

- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark shop menu cell delegate

- (void)homeShopMenuCell:(IOHomeShopMenuCell *)shopMenuCell dishPrice:(float)dishPrice clickedBtn:(UIButton *)btn{
    if (btn.tag == 1) {
        _shoppingView.checkOutView.backgroundColor = [UIColor orangeColor];
        _shoppingView.shoppingCarBtn.enabled = YES;
        _shoppingView.totalPrice.textColor = [UIColor greenColor];
        if ([_shoppingView.totalPrice.text isEqualToString:@"购物车是空的"]) {
            _shoppingView.totalPrice.text = @"0.00";
            _shoppingView.checkOutBtn.enabled = YES;
        }
        _shoppingView.badge.badgeValue = [NSString stringWithFormat:@"%lld", [_shoppingView.badge.badgeValue longLongValue] + 1];
        _shoppingView.totalPrice.text = [NSString stringWithFormat:@"¥%.2f", ([[_shoppingView.totalPrice.text substringFromIndex:1] floatValue] + dishPrice)];
    }else{
        _shoppingView.badge.badgeValue = [NSString stringWithFormat:@"%lld", [_shoppingView.badge.badgeValue longLongValue] - 1];
        _shoppingView.totalPrice.text = [NSString stringWithFormat:@"¥%.2f", ([[_shoppingView.totalPrice.text substringFromIndex:1] floatValue] - dishPrice)];
        if ([_shoppingView.totalPrice.text isEqualToString:@"¥0.00"]) {
            _shoppingView.checkOutBtn.enabled = NO;
            _shoppingView.checkOutView.backgroundColor = [UIColor lightGrayColor];
            _shoppingView.shoppingCarBtn.enabled = NO;
            _shoppingView.totalPrice.textColor = [UIColor lightGrayColor];
            _shoppingView.totalPrice.text = @"购物车是空的";
        }
    }
}

@end
