//
//  IOSubmitViewController.m
//  iOrder
//
//  Created by 易无解 on 5/25/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IOSubmitViewController.h"

#import "MBProgressHUD.h"
#import "UIBarButtonItem+IOBarButtonItem.h"
#import "IOSubmitOrderView.h"
#import "IOSubmitCell.h"

#import "IOShop.h"
#import "IOHomeManager.h"
#import "IOOrderSubmitParam.h"
#import "IOOrderSubmitResult.h"
#import "MBProgressHUD+YWJ.h"

extern BOOL isInRegion;

@interface IOSubmitViewController ()<UITableViewDataSource, UITableViewDelegate, IOSubmitOrderViewDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) IOSubmitOrderView *submitOrderView;

@end

@implementation IOSubmitViewController

#pragma mark - 系统回调函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = IORGBColor(245, 245, 245, 1);
    *(_isRefresh) = YES;
    [self setupNavigationItem];
    
    [self setupTableView];
    
    [self setupSubmitOrderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置界面相关函数

- (void)setupSubmitOrderView {
    IOSubmitOrderView *submitOrderView = [[IOSubmitOrderView alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    submitOrderView.delegate = self;
    [self.view addSubview:submitOrderView];
    _submitOrderView = submitOrderView;
    
    submitOrderView.price = _totalPrice;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 44)];
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.backgroundColor = IORGBColor(245, 245, 245, 1);
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

#pragma mark - 事件监听函数

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 2;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell = [[IOSubmitCell alloc] init];
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
                ((IOSubmitCell2 *)cell).title = _shopInfo.name;
                ((IOSubmitCell2 *)cell).detail = @"由 商家 配送";
                break;
                
            case 1:
                cell = [[IOSubmitCell3 alloc] init];
                ((IOSubmitCell3 *)cell).title = [NSString stringWithFormat:@"总计 %.2f", [[_totalPrice substringFromIndex:2] floatValue]];
                ((IOSubmitCell3 *)cell).detail = [NSString stringWithFormat:@"实付 %.2f", [[_totalPrice substringFromIndex:2] floatValue]];
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

#pragma mark - IOSubmitOrderViewDelegate

- (void)submitOrderView:(IOSubmitOrderView *)submitOrderView submitClicked:(UIButton *)btn {
    // 判断是否在点餐区域
    if (isInRegion == YES) {
        // 确认是否提交订单
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"是否提交订单？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // 先开始转菊花
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            // Change the background view style and color.
            hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
            hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
            
            // Set the label text.
            hud.label.text = NSLocalizedString(@"提交中...", @"HUD loading title");
            
            // 请求提交订单
            IOOrderSubmitParam *param = [[IOOrderSubmitParam alloc] init];
            param.shopId = self.shopInfo.shopId;
            param.couponId = 0;
            
            [IOHomeManager submitOrderWithParam:param success:^(IOOrderSubmitResult * _Nullable result) {
                if (result.result == YES) {
                    // 提交成功，在主线程提示
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MBProgressHUD *hud1 = [MBProgressHUD HUDForView:self.view];
                        
                        UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                        hud1.customView = imageView;
                        hud1.mode = MBProgressHUDModeCustomView;
                        hud1.label.text = NSLocalizedString(@"提交成功", @"HUD completed title");
                        float delay = 1.5;
                        [hud1 hideAnimated:YES afterDelay:delay];
                        // 回到店铺页面
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    });
                    // 清空购物车
                    if ([_delegate respondsToSelector:@selector(submitViewController:isPaySuccessful:)]) {
                        [_delegate submitViewController:self isPaySuccessful:YES];
                    }
                } else {
                    // 提交失败
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // Set the custom view mode to show any view.
                        hud.mode = MBProgressHUDModeCustomView;
                        // Set an image view with a checkmark.
                        UIImage *image = [[UIImage imageNamed:@"error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                        hud.customView = [[UIImageView alloc] initWithImage:image];
                        // Looks a bit nicer if we make it square.
                        hud.square = YES;
                        // Optional label text.
                        hud.label.text = NSLocalizedString(@"订单提交失败！", @"HUD failed title");
                        
                        [hud hideAnimated:YES afterDelay:1.5];
                    });
                }
            } failure:^(NSError * _Nonnull error) {
                // 请求失败
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Set the custom view mode to show any view.
                    hud.mode = MBProgressHUDModeCustomView;
                    // Set an image view with a error img.
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
        
    } else {
        
        // 提示未在点餐区域不能提交订单
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"您尚未进入点餐区域！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:defaultAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }
}

/*
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = NSLocalizedString(@"提交中...", @"HUD preparing title");
        
        
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            [self doSomeWork];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                MBProgressHUD *hud1 = [MBProgressHUD HUDForView:self.view];
                
                UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                hud1.customView = imageView;
                hud1.mode = MBProgressHUDModeCustomView;
                hud1.label.text = NSLocalizedString(@"提交成功", @"HUD completed title");
                
                [hud1 hideAnimated:YES afterDelay:1.f];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([_delegate respondsToSelector:@selector(submitViewController:isPaySuccessful:)]) {
                        [_delegate submitViewController:self isPaySuccessful:YES];
                    }
                    IOOrderGenerateParam *param = [[IOOrderGenerateParam alloc] init];
                    param.shopId = weakSelf.shopInfo.shopId;
                    param.couponId = 0;
                    [IOHomeManager submitOrderWithParam:param success:^(IOOrderGenerateResult * _Nullable result) {
                        if (result.code == 2000) {
                            IOLog(@"提交成功");
                        }
                    } failure:^(NSError * _Nullable error) {
                        IOLog(@"%@", error);
                    }];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            });
        });
    }
}

- (void)doSomeWork {
    sleep(2.);
}
 */

@end
