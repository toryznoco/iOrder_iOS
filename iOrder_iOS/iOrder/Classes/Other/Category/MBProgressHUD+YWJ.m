//
//  MBProgressHUD+YWJ.m
//  RongFuHui
//
//  Created by 易无解 on 07/02/2017.
//  Copyright © 2017 TianLiWuYe. All rights reserved.
//

#import "MBProgressHUD+YWJ.h"

@implementation MBProgressHUD (YWJ)

#pragma mark - 显示信息

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];          //将view设置为最前面的一个view
    }
    //快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    
    //设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    //在设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    //隐藏时从父控件移除
    hud.removeFromSuperViewOnHide = YES;
    
    //1秒后在消失
    [hud hideAnimated:YES afterDelay:0.7];
}

#pragma mark - 显示错误信息

+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}

#pragma mark - 显示一些信息

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];          //将view设置为最前面的一个view
    }
    //快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    
    //隐藏时从父控件移除
    hud.removeFromSuperViewOnHide = YES;
    
    //蒙板效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
        [self hideHUDForView:view animated:YES];
    }
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

@end
