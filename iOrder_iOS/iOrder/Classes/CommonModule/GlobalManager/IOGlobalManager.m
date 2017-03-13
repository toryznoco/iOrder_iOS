//
//  IOGlobalManager.m
//  iOrder
//
//  Created by Tory on 07/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOGlobalManager.h"
#import "AprilBeaconSDK.h"
#import "IOTransmitters.h"
#import "YWJRootTool.h"
#import "IORootTool.h"
#import "YWJVersionTool.h"
#import <CoreBluetooth/CoreBluetooth.h>

#import "YWJRootNavigationViewController.h"
#import "IONewFeatureViewController.h"
#import "IOLoginViewController.h"
#import "YWJVersionTool.h"

#import "IONewFeatureViewController.h"
#import "IOTabBarController.h"

@import UserNotifications;

BOOL isInRegion = NO;

@interface IOGlobalManager () <ABBeaconManagerDelegate, CBCentralManagerDelegate, UNUserNotificationCenterDelegate>

/** beacon管理者 */
@property (nonatomic, strong) ABBeaconManager *beaconManager;

/** 蓝牙管理者 */
@property (nonatomic, strong) CBCentralManager *centralManager;

/** 监听区域 */
@property (nonatomic, strong) ABBeaconRegion *region;

@end

@implementation IOGlobalManager

#pragma mark - 单例

Singleton_implementation(Manager)

#pragma mark - 初始化方法

- (instancetype)init {
    if (self = [super init]) {
        // 设置通知中心代理
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        
        // 设置beacon管理者及代理
        _beaconManager = [[ABBeaconManager alloc] init];
        _beaconManager.delegate = self;
        
        // 请求总是允许访问位置，同时就允许了使用蓝牙探测iBeacon
        [_beaconManager requestAlwaysAuthorization];
        
        // 设置蓝牙管理者及代理
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    }
    return self;
}


#pragma mark - 选择根控制器
/** 根据情况选择根控制器 */
+ (void)chooseRootViewController {
    // 直接进入登录界面
    [[IOGlobalManager sharedManager] enterLogin];
    
    /*
    // 进入App，先判断版本
    // 版本号大于存的版本号就进入新特性页面，并保存新的版本号
//    [YWJVersionTool saveVersion:@"0.1"];
    
    // 当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 之前保存的版本
    NSString *savedVersion = [YWJVersionTool savedVersion];
    
    if ([currentVersion isEqualToString:savedVersion]) { // 版本号相同
        // 判断有无本地账号，有则自动登录进入首页，没有则进入登录界面
        // 这里默认没有存储账号，直接进入登录页面
        [self enterLogin];
        
    } else { // 版本号不同，进入新特性页面
        IONewFeatureViewController *newFeatureVC = [[IONewFeatureViewController alloc] init];
        
        [IORootTool changeRootViewControllerTo:newFeatureVC];
        
        [YWJVersionTool saveVersion:currentVersion];
    }
     */
}

// 进入登录页面
- (void)enterLogin {
    IOLoginViewController *loginVc = [[IOLoginViewController alloc] init];
    YWJRootNavigationViewController *loginNav = [[YWJRootNavigationViewController alloc] initWithRootViewController:loginVc];
    
    [IORootTool changeRootViewControllerTo:loginNav];
}

// 进入主页
- (void)enterHome {
    // 切换窗口根控制器到tabBarVC
    IOTabBarController *tabBarVC = [[IOTabBarController alloc] init];
    [IORootTool changeRootViewControllerTo:tabBarVC];
}

#pragma mark - 开始监听iBeacon
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
    }
    
    [self.beaconManager startMonitoringForRegion:self.region];
    IOLog(@"开始监控");
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    IOLog(@"%s--开始检测蓝牙", __func__);
    IOLog(@"%d", [ABBeaconManager authorizationStatus]);
    
    // 判断蓝牙状态
    // 不可用就提示用户开启蓝牙并授权
    NSString *message = nil;
    UIAlertAction *rightAction = nil;
    switch (central.state) {
        // CBManagerStateUnknown 未知，提示设备未知
        case 0:
            break;

        // CBManagerStateResetting 重置中
        case 1:
            break;

        // CBManagerStateUnsupported 不支持蓝牙，提示用户设备不支持
        case 2:
            message = @"设备不支持蓝牙，请您去前台点餐。";
            break;

        // CBManagerStateUnauthorized 蓝牙未授权，提示用户设置为总是
            // The application is not authorized to use the Bluetooth Low Energy role.
        case 3:
            message = @"您尚未允许使用蓝牙，请设置为\"允许。\"，方便您点餐";
            rightAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                // 跳转到设置页面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            break;

        // CBManagerStatePoweredOff 未打开蓝牙，提示用户去打开
        case 4:
            message = @"蓝牙已关闭，为了方便您的点餐，请打开蓝牙。";
            break;

        // CBManagerStatePoweredOn 蓝牙已开启且已授权，开始监听
        case 5:
            [self startMonitoringForRegion];
            break;

        default:
            break;
    }

    // 有message才提示用户
    if (message && message.length!=0) {
        IOLog(@"message == %@",message);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        
        // 需要跳转才添加右边按钮
        if (rightAction) {
            [alert addAction:rightAction];
        }

        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - ABBeaconManagerDelegate
// 进入区域
- (void)beaconManager:(ABBeaconManager *)manager didEnterRegion:(ABBeaconRegion *)region {
    isInRegion = YES;
    IOLog(@"进入区域了");
    NSString *contentBody = [NSString localizedUserNotificationStringForKey:@"欢迎进入点餐区域！"
                                                                  arguments:nil];
    
    [self pushNotificationWithContentBody:contentBody identifier:@"EnterRegion"];
}

// 退出区域
- (void)beaconManager:(ABBeaconManager *)manager didExitRegion:(ABBeaconRegion *)region {
    isInRegion = NO;
    IOLog(@"退出区域了");
    NSString *contentBody= [NSString localizedUserNotificationStringForKey:@"您已退出点餐区域，欢迎下次再来！"
                                                                 arguments:nil];
    
    [self pushNotificationWithContentBody:contentBody identifier:@"ExitRegion"];
}

// 监听失败
- (void)beaconManager:(ABBeaconManager *)manager monitoringDidFailForRegion:(ABBeaconRegion *)region withError:(NSError *)error {
    IOLog(@"manager = %@, region = %@, error = %@", manager, region, error);
}

#pragma mark - Private Method
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
            IOLog(@"%@", error);
        }
    }];
    
    //    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //    notification.alertBody = @"欢迎进入点餐区域！";
    //    notification.soundName = UILocalNotificationDefaultSoundName;
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    //  设置应用程序右上角的提醒个数
    //    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}

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
