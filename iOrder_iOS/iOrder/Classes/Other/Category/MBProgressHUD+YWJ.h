//
//  MBProgressHUD+YWJ.h
//  RongFuHui
//
//  Created by 易无解 on 07/02/2017.
//  Copyright © 2017 TianLiWuYe. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (YWJ)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;              //显示成功到指定View
+ (void)showError:(NSString *)error toView:(UIView *)view;                  //显示失败到指定View

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;   //显示消息到指定View

+ (void)showSuccess:(NSString *)success;                                    //显示成功到当前View
+ (void)showError:(NSString *)error;                                        //显示失败到当前View

+ (MBProgressHUD *)showMessage:(NSString *)message;                         //显示消息到当前View

+ (void)hideHUDForView:(UIView *)view;                                      //隐藏指定View的HUD
+ (void)hideHUD;                                                            //隐藏当前View的HUD

@end
