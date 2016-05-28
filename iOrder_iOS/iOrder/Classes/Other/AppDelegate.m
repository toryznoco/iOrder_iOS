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

BOOL isInRegion;

@interface AppDelegate ()

@property (nonatomic, strong) ABBeaconRegion *region;

@property (nonatomic) UIBackgroundTaskIdentifier taskId;

@end

@implementation AppDelegate

#pragma mark - self

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  创建beacon管理者
    self.beaconManager = [[ABBeaconManager alloc] init];
    //  设置beacon的代理
    self.beaconManager.delegate = self;
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        //  注册通知
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    application.networkActivityIndicatorVisible=YES;
    
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
    
    application.applicationIconBadgeNumber = 0;
    if (isInRegion == NO) {
        //  开始检测
        [self startMonitoring];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:notification.alertBody delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)startMonitoring {
    IOTransmitters *tran = [IOTransmitters sharedTransmitters];
    [[tran transmitters] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:obj[@"uuid"]];
        self.region = [[ABBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:proximityUUID.UUIDString];
    }];
    self.region.notifyOnEntry = YES;
    self.region.notifyOnExit = YES;
    self.region.notifyEntryStateOnDisplay = YES;
    [_beaconManager startMonitoringForRegion:self.region];
}

#pragma mark - beacon manager delegate
- (void)beaconManager:(ABBeaconManager *)manager didEnterRegion:(ABBeaconRegion *)region {
    isInRegion = YES;
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"欢迎进入点餐区域！";
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    //  设置应用程序右上角的提醒个数
    [UIApplication sharedApplication].applicationIconBadgeNumber++;
}

- (void)beaconManager:(ABBeaconManager *)manager didExitRegion:(ABBeaconRegion *)region {
    isInRegion = NO;
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"您已退出点餐区域，欢迎下次再来！";
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    //  设置应用程序右上角的提醒个数
    [UIApplication sharedApplication].applicationIconBadgeNumber++;
}

@end
