//
//  IOSubmitViewController.m
//  iOrder
//
//  Created by 易无解 on 5/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "IOSubmitViewController.h"

#import "UIBarButtonItem+IOBarButtonItem.h"
#import "IOSubmitOrderView.h"
#import "IOSubmitCell.h"

#import "IOShop.h"

@interface IOSubmitViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) IOSubmitOrderView *submitOrderView;

@end

@implementation IOSubmitViewController

#pragma mark - privacy

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YWJRGBColor(245, 245, 245, 1);
    
    [self setupNavigationItem];
    
    [self setupTableView];
    
    [self setupSubmitOrderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell = [[IOSubmitCell alloc] initWithFrame:CGRectMake(0, 0, 414, 43.667)];
                ((IOSubmitCell *)cell).title = @"支付方式";
                ((IOSubmitCell *)cell).detail = @"在线支付";
                break;
                
            case 1:
                cell = [[IOSubmitCell1 alloc] init];
                ((IOSubmitCell1 *)cell).title = @"iOrder红包";
                ((IOSubmitCell1 *)cell).detail = @"暂无可用红包";
                break;
                
            case 2:
                cell = [[IOSubmitCell1 alloc] init];
                ((IOSubmitCell1 *)cell).title = @"商家代金券";
                ((IOSubmitCell1 *)cell).detail = @"暂无代金券可用";
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell = [[IOSubmitCell2 alloc] init];
                ((IOSubmitCell2 *)cell).iconName = @"submit_send";
                ((IOSubmitCell2 *)cell).title = @"立集体的空间反馈";
                ((IOSubmitCell2 *)cell).detail = @"由 商家 配送";
                break;
                
            case 1:
                cell = [[IOSubmitCell3 alloc] init];
                ((IOSubmitCell3 *)cell).title = @"配送费";
                ((IOSubmitCell3 *)cell).detail = @"¥ 18";
                break;
                
            case 2:
                cell = [[IOSubmitCell3 alloc] init];
                ((IOSubmitCell3 *)cell).title = @"总计 ¥ 18";
                ((IOSubmitCell3 *)cell).detail = @"实付 ¥ 18";
                break;
                
            default:
                break;
        }
    } else {
        cell = [[IOSubmitCell1 alloc] init];
        switch (indexPath.row) {
            case 0:
                ((IOSubmitCell1 *)cell).title = @"用餐人数";
                ((IOSubmitCell1 *)cell).detail = @"以便商家给您带够餐具";
                break;
                
            case 1:
                ((IOSubmitCell1 *)cell).title = @"备注";
                ((IOSubmitCell1 *)cell).detail = @"可输入偏好、忌口等需求";
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}

#pragma mark - custom methods

- (void)setupSubmitOrderView {
    IOSubmitOrderView *submitOrderView = [[IOSubmitOrderView alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    [self.view addSubview:submitOrderView];
    _submitOrderView = submitOrderView;
    
    submitOrderView.price = _totalPrice;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 44 - 240)];
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.scrollEnabled = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)setupNavigationItem {
    self.title = @"提交订单";
    UIColor *titleColor = [UIColor whiteColor];
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = titleColor;
    self.navigationController.navigationBar.titleTextAttributes = titleAttr;
    UIBarButtonItem *backBtn = [UIBarButtonItem initWithNormalImage:@"arrow" target:self action:@selector(backBtnClick) width:12 height:21];
    self.navigationItem.leftBarButtonItem = backBtn;
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
