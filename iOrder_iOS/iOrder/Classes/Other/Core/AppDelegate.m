//
//  AppDelegate.m
//  iOrder
//
//  Created by 易无解 on 3/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//



#import "AppDelegate.h"

#import "YWJRootTool.h"
#import "YWJVersionTool.h"

#import "AFNetworking.h"

#import "IOTransmitters.h"

@import UserNotifications;

BOOL isInRegion;

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@property (nonatomic) UIBackgroundTaskIdentifier taskId;

@property (nonatomic, strong) ABBeaconRegion *region;

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  创建beacon管理者
    self.beaconManager = [[ABBeaconManager alloc] init];
    //  设置beacon的代理
    self.beaconManager.delegate = self;
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    //  iOS 10以后注册通知
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionBadge + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"granted = %d", granted);
    }];
    
    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
//    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//        NSLog(@"settings = %@", settings);
//    }];
    
    //  iOS 8-10注册通知
//    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
//        //  注册通知
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//    }
    
//    application.networkActivityIndicatorVisible=YES;
    
#warning 以后不需要此行代码，此处便于调试
    // 1.进入App，先判断版本，版本号大于存的版本号就显示新特性页面
    
    
    // 2.判断有无本地账号，有的话则进入首页，没有就弹出登录界面
    [YWJVersionTool saveVersion:@"0.1"];
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, IOScreenWidth, IOScreenHeight)];
    [self.window makeKeyAndVisible];
    
    [YWJRootTool chooseRootViewController:self.window];
    
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

    // 设置请求总是允许访问
    if (!(kCLAuthorizationStatusAuthorizedAlways == [ABBeaconManager authorizationStatus])) {
        [self.beaconManager requestAlwaysAuthorization];
    }
    
    //  开始监测
    [self startMonitoringForRegion];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:notification.alertBody delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
//}

#pragma mark - Custom methods
- (void)startMonitoringForRegion {
    if (!self.region) {  //  region没有值就创建
        IOTransmitters *tran = [IOTransmitters sharedTransmitters];
        NSDictionary *dict = [[tran transmitters] lastObject];
        NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:dict[@"uuid"]];
        self.region = [[ABBeaconRegion alloc] initWithProximityUUID:proximityUUID
                                                         identifier:dict[@"uuid"]];
        self.region.notifyOnEntry = YES;
        self.region.notifyOnExit = YES;
        self.region.notifyEntryStateOnDisplay = YES;
    } else {    //  region有值就先停掉之前的
            [self.beaconManager stopMonitoringForRegion:self.region];
    }
    NSLog(@"self.region = %@", self.region);
    [self.beaconManager startMonitoringForRegion:self.region];
    NSLog(@"开始监控");
}

#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"要发推送了");
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:response.notification.request.content.body preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:response.notification.request.content.body delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
//    [alert show];
}

#pragma mark - beacon manager delegate
- (void)beaconManager:(ABBeaconManager *)manager monitoringDidFailForRegion:(ABBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"manager = %@, region = %@, error = %@", manager, region, error);
}

- (void)beaconManager:(ABBeaconManager *)manager didEnterRegion:(ABBeaconRegion *)region {
    isInRegion = YES;
    NSLog(@"进入区域了");
    NSString *contentBody = [NSString localizedUserNotificationStringForKey:@"欢迎进入点餐区域！"
                                                                  arguments:nil];
    
    [self pushNotificationWithContentBody:contentBody identifier:@"EnterRegion"];
}

- (void)beaconManager:(ABBeaconManager *)manager didExitRegion:(ABBeaconRegion *)region {
    isInRegion = NO;
    NSLog(@"退出区域了");
    NSString *contentBody= [NSString localizedUserNotificationStringForKey:@"您已退出点餐区域，欢迎下次再来！"
                                                                 arguments:nil];
    
    [self pushNotificationWithContentBody:contentBody identifier:@"ExitRegion"];
}

/**
 推送beacon通知

 @param contentBody 提示内容
 @param identifier  通知标识
 */
- (void)pushNotificationWithContentBody:(NSString *)contentBody identifier:(NSString *)identifier {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"温馨提示"
                                                          arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:contentBody
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    //  设置应用程序右上角的提醒个数
    content.badge = @1;
    
    //  时间触发器
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
    //  创建推送通知请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content
                                                                          trigger:trigger];
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"%@", error);
        }
    }];
    
    //    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //    notification.alertBody = @"欢迎进入点餐区域！";
    //    notification.soundName = UILocalNotificationDefaultSoundName;
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    //  设置应用程序右上角的提醒个数
//    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}

@end
