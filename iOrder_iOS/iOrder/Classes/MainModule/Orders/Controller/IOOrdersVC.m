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
#import "MBProgressHUD.h"

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
        NSMutableArray *tempLayouts = @[].mutableCopy;
        [orders enumerateObjectsUsingBlock:^(IOOrder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            IOOrderLayout *layout = [[IOOrderLayout alloc] initWithStatus:obj];
            [tempLayouts addObject:layout];
        }];
        self.layouts = tempLayouts;
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
- (void)payBtnDidClick:(UIButton *)btn order:(IOOrder *)order {
    IOLog(@"去支付");
    
    // 提示确认支付？
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"确认支付此订单？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // 开始支付，先转菊花
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Change the background view style and color.
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
        
        // Set the label text.
        hud.label.text = NSLocalizedString(@"支付中...", @"HUD loading title");
        
        // 发支付请求
        IOPayOrderParam *param = [[IOPayOrderParam alloc] init];
        param.orderId = order.orderId;
        
        [IOOrdersManager payOrder:param success:^(IOHTTPBaseResult * _Nullable result) {
            if (result.result == YES) {
                // 支付成功，通知主线程提示，并刷新页面
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 提示支付成功
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MBProgressHUD *hud1 = [MBProgressHUD HUDForView:self.view];
                        
                        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                        hud1.customView = imageView;
                        hud1.mode = MBProgressHUDModeCustomView;
                        hud1.label.text = NSLocalizedString(@"支付成功", @"HUD completed title");
                        float delay = 1.5;
                        [hud1 hideAnimated:YES afterDelay:delay];
                        // 通知主线程刷新页面
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.tableView.mj_header beginRefreshing];
                        });
                    });
                });
            } else {
                // 支付失败，在主线程提示
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Set the custom view mode to show any view.
                    hud.mode = MBProgressHUDModeCustomView;
                    // Set an image view with a checkmark.
                    UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    hud.customView = [[UIImageView alloc] initWithImage:image];
                    // Looks a bit nicer if we make it square.
                    hud.square = YES;
                    // Optional label text.
                    hud.label.text = NSLocalizedString(@"支付失败", @"HUD failed title");
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                });
            }
        } failure:^(NSError * _Nonnull error) {
            // 请求失败
            dispatch_async(dispatch_get_main_queue(), ^{
                // Set the custom view mode to show any view.
                hud.mode = MBProgressHUDModeCustomView;
                // Set an image view with a checkmark.
                UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                hud.customView = [[UIImageView alloc] initWithImage:image];
                // Looks a bit nicer if we make it square.
                hud.square = YES;
                // Optional label text.
                hud.label.text = NSLocalizedString(error.localizedDescription, @"HUD failed title");
                
                [hud hideAnimated:YES afterDelay:1.5];
            });
        }];
    }];
    
    [alert addAction:defaultAction];
    [alert addAction:rightAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)cancelBtnDidClick:(UIButton *)btn order:(IOOrder *)order {
    IOLog(@"取消订单");
    
    // 提示确认取餐？
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"您真的要取消此订单吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        // 开始取消订单，先转菊花
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Change the background view style and color.
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
        
        // Set the label text.
        hud.label.text = NSLocalizedString(@"取消中...", @"HUD loading title");
        
        // 发取消请求
        IOCancelOrderParam *param = [[IOCancelOrderParam alloc] init];
        param.orderId = order.orderId;
        
        [IOOrdersManager cancelOrder:param success:^(IOHTTPBaseResult * _Nullable result) {
            if (result.result == YES) {
                // 取消成功，通知主线程提示，并刷新页面
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 提示取消成功
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MBProgressHUD *hud1 = [MBProgressHUD HUDForView:self.view];
                        
                        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                        hud1.customView = imageView;
                        hud1.mode = MBProgressHUDModeCustomView;
                        hud1.label.text = NSLocalizedString(@"订单取消成功", @"HUD completed title");
                        float delay = 1.5;
                        [hud1 hideAnimated:YES afterDelay:delay];
                        // 通知主线程刷新页面
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.tableView.mj_header beginRefreshing];
                        });
                    });
                });
            } else {
                // 取餐失败，在主线程提示
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Set the custom view mode to show any view.
                    hud.mode = MBProgressHUDModeCustomView;
                    // Set an image view with a checkmark.
                    UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    hud.customView = [[UIImageView alloc] initWithImage:image];
                    // Looks a bit nicer if we make it square.
                    hud.square = YES;
                    // Optional label text.
                    hud.label.text = NSLocalizedString(@"取餐失败", @"HUD failed title");
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                });
            }
        } failure:^(NSError * _Nonnull error) {
            // 请求失败
            dispatch_async(dispatch_get_main_queue(), ^{
                // Set the custom view mode to show any view.
                hud.mode = MBProgressHUDModeCustomView;
                // Set an image view with a checkmark.
                UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                hud.customView = [[UIImageView alloc] initWithImage:image];
                // Looks a bit nicer if we make it square.
                hud.square = YES;
                // Optional label text.
                hud.label.text = NSLocalizedString(error.localizedDescription, @"HUD failed title");
                
                [hud hideAnimated:YES afterDelay:1.5];
            });
        }];
    }];
    
    [alert addAction:defaultAction];
    [alert addAction:rightAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)alertBtnDidClick:(UIButton *)btn order:(IOOrder *)order {
    IOLog(@"催单");
}

- (void)getBtnDidClick:(UIButton *)btn order:(IOOrder *)order {
    IOLog(@"取餐");
    
    // 提示确认取餐？
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"确认取餐？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        // 开始取餐，先转菊花
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Change the background view style and color.
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
        
        // Set the label text.
        hud.label.text = NSLocalizedString(@"取餐中...", @"HUD loading title");
        
        // 发取餐请求
        IOGetDishParam *param = [[IOGetDishParam alloc] init];
        param.orderId = order.orderId;
        
        [IOOrdersManager getDish:param success:^(IOHTTPBaseResult * _Nullable result) {
            if (result.result == YES) {
                // 取餐成功，通知主线程提示，并刷新页面
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 提示取餐成功
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MBProgressHUD *hud1 = [MBProgressHUD HUDForView:self.view];
                        
                        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                        hud1.customView = imageView;
                        hud1.mode = MBProgressHUDModeCustomView;
                        hud1.label.text = NSLocalizedString(@"取餐成功", @"HUD completed title");
                        float delay = 1.5;
                        [hud1 hideAnimated:YES afterDelay:delay];
                        // 通知主线程刷新页面
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.tableView.mj_header beginRefreshing];
                        });
                    });
                });
            } else {
                // 取餐失败，在主线程提示
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Set the custom view mode to show any view.
                    hud.mode = MBProgressHUDModeCustomView;
                    // Set an image view with a checkmark.
                    UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    hud.customView = [[UIImageView alloc] initWithImage:image];
                    // Looks a bit nicer if we make it square.
                    hud.square = YES;
                    // Optional label text.
                    hud.label.text = NSLocalizedString(@"取餐失败", @"HUD failed title");
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                });
            }
        } failure:^(NSError * _Nonnull error) {
            // 请求失败
            dispatch_async(dispatch_get_main_queue(), ^{
                // Set the custom view mode to show any view.
                hud.mode = MBProgressHUDModeCustomView;
                // Set an image view with a checkmark.
                UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                hud.customView = [[UIImageView alloc] initWithImage:image];
                // Looks a bit nicer if we make it square.
                hud.square = YES;
                // Optional label text.
                hud.label.text = NSLocalizedString(error.localizedDescription, @"HUD failed title");
                
                [hud hideAnimated:YES afterDelay:1.5];
            });
        }];
    }];
    
    [alert addAction:defaultAction];
    [alert addAction:rightAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)commentBtnDidClick:(UIButton *)btn order:(IOOrder *)order {
    IOLog(@"去评价");
}

@end
