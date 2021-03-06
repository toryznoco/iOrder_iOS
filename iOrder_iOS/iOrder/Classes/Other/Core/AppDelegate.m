//
//  AppDelegate.m
//  iOrder
//
//  Created by 易无解 on 3/25/16.
//  Copyright © 2016 normcore. All rights reserved.
//



#import "AppDelegate.h"

#import "AFNetworking.h"

#import "IOGlobalManager.h"
#import "IQKeyboardManager.h"

@import UserNotifications;
@import CoreLocation;

@interface AppDelegate ()

@property (nonatomic) UIBackgroundTaskIdentifier taskId;

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 开启键盘管理者
    [IQKeyboardManager sharedManager].enable = YES;
    
    // 注册通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    //  iOS 10以后注册通知
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionBadge + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        IOLog(@"granted = %d", granted);
    }];
    
    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
//    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//        IOLog(@"settings = %@", settings);
//    }];
    
    //  iOS 8-10注册通知
//    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
//        //  注册通知
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//    }
    
//    application.networkActivityIndicatorVisible = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, IOScreenWidth, IOScreenHeight)];
    [self.window makeKeyAndVisible];
    
    // 全局管理者根据情况选择根控制器
    [[IOGlobalManager sharedManager] chooseRootViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//    进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    self.taskId = [application beginBackgroundTaskWithExpirationHandler:^{
//        后台结束时调用
        [application endBackgroundTask:self.taskId];
        self.taskId = UIBackgroundTaskInvalid;
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    application.applicationIconBadgeNumber = 0;
    
    // 检查 允许总是使用位置信息，允许推送通知
    if (!([IOGlobalManager checkIfAllowAlwaysUseLocation] && [IOGlobalManager checkIfAllowPushNotification])) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"您尚未允许总是使用位置信息或推送通知，为了方便您点餐，请设置为总是和允许。" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // 跳转到设置页面
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        
        [alert addAction:defaultAction];
        [alert addAction:rightAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:notification.alertBody delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
//}





@end
