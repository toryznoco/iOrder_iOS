//
//  IOShoppingCartViewController.m
//  iOrder
//
//  Created by 易无解 on 13/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOShoppingCartViewController.h"

#import "IOShoppingCartCell.h"
#import "IODishInfo.h"
#import "IOHomeManager.h"
#import "IOShoppingCartAddParam.h"
#import "IOShoppingCartAddResult.h"
#import "IOShoppingCartDropParam.h"
#import "IOShoppingCartDropResult.h"
#import "IOShoppingCartResult.h"

@interface IOShoppingCartViewController ()<IOShoppingCartCellDelegate>

@end

@implementation IOShoppingCartViewController

#pragma mark - 系统回调函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IOScreenWidth, 44)];
    UILabel *title = [[UILabel alloc] initWithFrame:headerView.frame];
    title.backgroundColor = [UIColor lightGrayColor];
    title.text = @"购物车";
    title.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:title];
    self.tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.shoppingCartInfo.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IOShoppingCartCell *cell = [IOShoppingCartCell cellWithTableView:tableView];
    IOShoppingCartItem *dish = self.shoppingCartInfo.items[indexPath.row];
    cell.item = dish;
    cell.delegate = self;
    
    return cell;
}

#pragma mark - IOShoppingCartCellDelegate

- (void)shoppingCartCell:(IOShoppingCartCell *)shoppingCartCell dishItem:(IOShoppingCartItem *)item clickedBtn:(UIButton *)btn {
    if (item.amount == 0) {
        [self.shoppingCartInfo.items removeObject:item];
        [self.tableView reloadData];
    }
        if (btn.tag == 1) {
            IOShoppingCartAddParam *param = [[IOShoppingCartAddParam alloc] init];
            param.goodsId = item.goods.goodsId;
            param.amount = 1;
            [IOHomeManager addDishToShoppingCartWithParam:param success:^(IOShoppingCartAddResult * _Nullable result) {
                if (result.code == 2000) {
                    IOLog(@"添加成功");
                    if (self.shoppingCartInfo.items.count == 0) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    if ([self.delegate respondsToSelector:@selector(shoppingCartViewController:dishItem:clickedBtn:)]) {
                        [self.delegate shoppingCartViewController:self dishItem:item clickedBtn:btn];
                    }
                }
            } failure:^(NSError * _Nullable error) {
                IOLog(@"%@", error);
            }];
    
        } else {
            IOShoppingCartDropParam *param = [[IOShoppingCartDropParam alloc] init];
            param.goodsId = item.goods.goodsId;
            param.amount = 1;
            [IOHomeManager dropDishFromShoppingCartWithParam:param success:^(IOShoppingCartDropResult * _Nullable result) {
                if (result.code == 2000) {
                    IOLog(@"移除成功");
                    if (self.shoppingCartInfo.items.count == 0) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    if ([self.delegate respondsToSelector:@selector(shoppingCartViewController:dishItem:clickedBtn:)]) {
                        [self.delegate shoppingCartViewController:self dishItem:item clickedBtn:btn];
                    }
                }
            } failure:^(NSError * _Nullable error) {
                IOLog(@"%@", error);
            }];
        }
}

@end
