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

@import UserNotifications;

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@property (nonatomic) UIBackgroundTaskIdentifier taskId;

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 注册通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
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
    
//    application.networkActivityIndicatorVisible=YES;
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, IOScreenWidth, IOScreenHeight)];
    [self.window makeKeyAndVisible];
    
    // 全局管理者根据情况选择根控制器
    [IOGlobalManager chooseRootViewController];
    
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
//    application.applicationIconBadgeNumber = 0;

    // 检测蓝牙状态，如果没有允许就向用户询问
    
    // 设置请求总是允许访问
//    if (!(kCLAuthorizationStatusAuthorizedAlways == [ABBeaconManager authorizationStatus])) {
//        [self.beaconManager requestAlwaysAuthorization];
//    }
    
    //  开始监测
//    [[IOGlobalManager sharedManager] startMonitoringForRegion];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:notification.alertBody delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
//}

#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    IOLog(@"要发推送了");
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:response.notification.request.content.body preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:response.notification.request.content.body delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
//    [alert show];
}





@end
