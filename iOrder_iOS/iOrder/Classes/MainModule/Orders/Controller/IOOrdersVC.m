//
//  IOOrdersVC.m
//  iOrder
//
//  Created by Tory on 24/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOOrdersVC.h"
#import "IOOrderLayout.h"
#import "IOOrderCell.h"
#import "MJRefresh.h"
#import "IOOrdersManager.h"

@interface IOOrdersVC () <UITableViewDataSource, UITableViewDelegate, IOOrderCellDelegate>

/** tableView */
@property (nonatomic, weak) UITableView *tableView;

/** 订单列表 */
@property (nonatomic, strong) NSMutableArray<IOOrderLayout *> *layouts;

@end

@implementation IOOrdersVC

#pragma mark - Private

- (NSMutableArray<IOOrderLayout *> *)layouts {
    if (!_layouts) {
        _layouts = [NSMutableArray array];
    }
    return _layouts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单";
    self.view.backgroundColor = kIOBackgroundColor;
    
    [self.navigationController.navigationBar setBarTintColor:kIOThemeColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IOScreenWidth, IOScreenHeight-49)];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    // 设置代理和数据源
    tableView.dataSource = self;
    tableView.delegate = self;
    
    // 设置UI
//    tableView.rowHeight = 150;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    
    //  添加下拉刷新控件
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrders)];
    //  请求最新订单数据
    [tableView.mj_header beginRefreshing];
}

- (void)loadNewOrders {
    [IOOrdersManager loadNewOrdersSuccess:^(NSArray<IOOrder *> * _Nullable orders) {
        [orders enumerateObjectsUsingBlock:^(IOOrder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            IOOrderLayout *layout = [[IOOrderLayout alloc] initWithStatus:obj];
            [self.layouts addObject:layout];
        }];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        IOLog(@"%@", error);
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.layouts[indexPath.row].height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    IOOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[IOOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Order"];
        cell.delegate = self;
    }
    [cell setLayout:_layouts[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IOLog(@"%ld", indexPath.row);
}

#pragma mark - IOOrderCellDelegate
- (void)payBtnDidClick:(UIButton *)btn {
    IOLog(@"去支付");
    // 可以用购物车那个页面
}

- (void)cancelBtnDidClick:(UIButton *)btn {
    IOLog(@"取消");
}

- (void)alertBtnDidClick:(UIButton *)btn {
    IOLog(@"催单");
}

- (void)getBtnDidClick:(UIButton *)btn {
    IOLog(@"取餐");
//    IOGetDishParam *param = [];
//    [IOOrdersManager getDish:<#(IOGetDishParam *)#> success:^(IOHTTPBaseResult * _Nullable result) {
//        IOLog(@"%@", result.message);
//    } failure:^(NSError * _Nonnull error) {
//        IOLog(@"%@", error);
//    }];
}

- (void)commentBtnDidClick:(UIButton *)btn {
    IOLog(@"去评价");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
