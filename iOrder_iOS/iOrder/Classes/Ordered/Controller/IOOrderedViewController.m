//
//  IOOrderedViewController.m
//  iOrder
//
//  Created by 易无解 on 4/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOOrderedViewController.h"

#import "IOOrder.h"
#import "IOOrderViewCell.h"

#import "MJRefresh.h"
#import "IOOrdersTool.h"

@interface IOOrderedViewController ()

@property (nonatomic, strong) NSMutableArray *orders;

@end

@implementation IOOrderedViewController

- (NSMutableArray *)orders {
    if (!_orders) {
        _orders = [NSMutableArray array];
    }
    return _orders;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单";
    
    //  背景颜色
    self.view.backgroundColor = kIOBackgroundColor;
    
    //    设置行高
    self.tableView.rowHeight = 150;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //  请求最新订单数据
    //  添加下拉刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrders)];
    [self.tableView.mj_header beginRefreshing];
}

//  {:json字典 [:json数组
#pragma mark - 请求最新订单
- (void)loadNewOrders
{
    [IOOrdersTool newOrdersSuccess:^(NSArray *orders){
        //  请求成功的block
        //  结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, orders.count)];
        //  把最新的订单插入到最前面
        [self.orders insertObjects:orders atIndexes:indexSet];
        
        //  刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orders.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //  创建cell
    IOOrderViewCell *cell = [IOOrderViewCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    //  获取模型
    IOOrder *order = self.orders[indexPath.row];

    //  传递模型
    cell.order = order;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
