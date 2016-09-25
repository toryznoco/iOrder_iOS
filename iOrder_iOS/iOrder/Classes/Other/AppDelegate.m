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

@property (nonatomic, strong) NSMutableArray<ABBeaconRegion *> *regions;

@property (nonatomic) UIBackgroundTaskIdentifier taskId;

@end

@implementation AppDelegate

#pragma mark - self

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  创建beacon管理者
    self.beaconManager = [[ABBeaconManager alloc] init];
    //  设置beacon的代理
    self.beaconManager.delegate = self;
    
    self.regions = [NSMutableArray array];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    //  iOS 10以后注册通知
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert  completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"granted = %d", granted);
    }];
    
    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"settings = %@", settings);
    }];
    
    //  iOS 8-10注册通知
//    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
//        //  注册通知
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
//    }
    
//    application.networkActivityIndicatorVisible=YES;
    
#warning 以后不需要此行代码，此处便于调试
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

- (void)startMonitoringForRegion {
    if (!self.regions.count) {  //  regions没有值就创建
        IOTransmitters *tran = [IOTransmitters sharedTransmitters];
        [[tran transmitters] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:obj[@"uuid"]];
            ABBeaconRegion *beaconRegion = [[ABBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:obj[@"name"]];
            beaconRegion.notifyOnEntry = YES;
            beaconRegion.notifyOnExit = YES;
            beaconRegion.notifyEntryStateOnDisplay = YES;
            [self.regions addObject:beaconRegion];
        }];
    } else {    //  regions有值就先停掉之前的
        for (int i = 0; i < self.regions.count; i++) {
            [self.beaconManager stopMonitoringForRegion:self.regions[i]];
        }
    }
    NSLog(@"%@", self.regions[1]);
    [self.beaconManager startMonitoringForRegion:self.regions[1]];
}

#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:response.notification.request.content.body delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - beacon manager delegate
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
    
    [self pushNotificationWithContentBody:contentBody identifier:@"EnterRegion"];
}

#pragma mark - 推送消息

/**
 推送beacon通知

 @param contentBody 提示内容
 @param identifier  通知标识
 */
- (void)pushNotificationWithContentBody:(NSString *)contentBody identifier:(NSString *)identifier {
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"提示"
                                                          arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:contentBody
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    //  设置应用程序右上角的提醒个数
    content.badge = @1;
    
    //  时间触发器
    UNTimeIntervalNotificationTrigger *timeTri = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1.0 repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content
                                                                          trigger:timeTri];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"推送添加成功");
    }];
    
    //    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //    notification.alertBody = @"欢迎进入点餐区域！";
    //    notification.soundName = UILocalNotificationDefaultSoundName;
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    //  设置应用程序右上角的提醒个数
//    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}

@end
