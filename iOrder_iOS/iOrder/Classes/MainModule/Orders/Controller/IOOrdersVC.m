//
//  IOOrdersVC.m
//  iOrder
//
//  Created by Tory on 24/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOOrdersVC.h"
#import "IOOrder.h"
#import "IOOrderCell.h"
#import "MJRefresh.h"
#import "IOOrdersManager.h"

@interface IOOrdersVC () <UITableViewDataSource, UITableViewDelegate>

/** tableView */
@property (nonatomic, weak) UITableView *tableView;

/** 订单列表 */
@property (nonatomic, strong) NSArray<IOOrder *> *orders;

@end

@implementation IOOrdersVC

#pragma mark - Private
- (NSArray *)orders {
    if (!_orders) {
        _orders = @[];
    }
    return _orders;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [UITableView new];
    [self.view addSubview:tableView];
    _tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrders)];
}

- (void)loadNewOrders {
    [IOOrdersManager loadNewOrdersSuccess:^(NSArray<IOOrder *> * _Nullable orders) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IOOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Order"];
    if (!cell) {
        cell = [[IOOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Order"];
    }
    cell.textLabel.text = self.orders[indexPath.row].shopName;
    return cell;
}

#pragma mark - UITableViewDelegate


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
