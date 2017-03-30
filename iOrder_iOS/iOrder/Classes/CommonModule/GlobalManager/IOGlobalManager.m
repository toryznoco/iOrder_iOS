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
#import "IONetworkTool.h"
#import "IOAccountTool.h"
#import "IOLoginResult.h"
#import "MBProgressHUD.h"

@import UserNotifications;

BOOL isInRegion = NO;
// 是否需要刷新两个token
BOOL ifNeededRefreshToken = NO;

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
        // 开始监听网络状态
        [IONetworkTool startMonitoring];
        
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


#pragma mark - Public Method
/** 进入App时，根据情况选择根控制器 */
- (void)chooseRootViewController {
    
    // 判断是否需要显示新特性页面，需要就显示
    if ([IOGlobalManager checkIfNeededShowNewFeature]) return [IOGlobalManager enterNewFeature];
    
    // 不需要新特性就判断是否需要登录
    if ([IOGlobalManager checkIfNeededLogin]) return [IOGlobalManager enterLogin];
    
    // 设置需要刷新两个Token
    ifNeededRefreshToken = YES;
    
    // 不需要登录就进入主页
    [IOGlobalManager enterHome];
}

/** 检测是否总是允许使用位置信息 */
+ (BOOL)checkIfAllowAlwaysUseLocation {
    return [ABBeaconManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways;
}

/**
 检测是否允许发送推送通知
 
 @return 是或否
 */
+ (BOOL)checkIfAllowPushNotification {
    __block UNAuthorizationStatus status = UNAuthorizationStatusDenied;
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        status = settings.authorizationStatus;
    }];
    return status == UNAuthorizationStatusAuthorized;
}

// 进入新特性页面
+ (void)enterNewFeature {
    IONewFeatureViewController *newFeatureVC = [[IONewFeatureViewController alloc] init];
    
    [IORootTool changeRootViewControllerTo:newFeatureVC];
}

// 进入登录页面
+ (void)enterLogin {
    IOLoginViewController *loginVc = [[IOLoginViewController alloc] init];
    YWJRootNavigationViewController *loginNav = [[YWJRootNavigationViewController alloc] initWithRootViewController:loginVc];
    
    [IORootTool changeRootViewControllerTo:loginNav];
}

// 进入主页
+ (void)enterHome {
    // 切换窗口根控制器到tabBarVC
    IOTabBarController *tabBarVC = [[IOTabBarController alloc] init];
    [IORootTool changeRootViewControllerTo:tabBarVC];
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
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
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
 检查是否需要显示新特性页面

 @return YES：需要，NO：不需要
 */
+ (BOOL)checkIfNeededShowNewFeature {
    return NO;
    /*
    //    [YWJVersionTool saveVersion:@"0.1"];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    NSString *savedVersion = [YWJVersionTool savedVersion];
    
    // 判断版本，版本相同就不需要显示，版本不同就需要显示
    if ([currentVersion isEqualToString:savedVersion]) {
        // 版本相同，不需要
        return NO;
    } else {
        // 版本不同，需要显示，并保存当前版本
        [YWJVersionTool saveVersion:currentVersion];
        return YES;
    }
     */
}

/**
 检查是否需要登录

 @return YES:需要，NO:不需要
 */
+ (BOOL)checkIfNeededLogin {
    // 检查refreshToken是否有效，有效就不需要登录，无效就需要登录
    return (![IOAccountTool checkIfRefreshTokenValid]);
}

/**
 推送beacon通知
 
 @param contentBody 提示内容
 @param identifier  通知标识
 */
- (void)pushNotificationWithContentBody:(NSString *)contentBody identifier:(NSString *)identifier {
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"温馨提示" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:contentBody arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    //  设置应用程序右上角的提醒个数
//    content.badge = @1;
    
    // Deliver the notification in 1 seconds.
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    // Schedule the notification.
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:nil];
    
    //    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //    notification.alertBody = @"欢迎进入点餐区域！";
    //    notification.soundName = UILocalNotificationDefaultSoundName;
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    //  设置应用程序右上角的提醒个数
    //    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
}


/** 
 开始监听iBeacon
 */
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
