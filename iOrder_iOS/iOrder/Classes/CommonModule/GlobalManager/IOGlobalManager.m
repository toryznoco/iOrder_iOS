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

@interface IOGlobalManager () <ABBeaconManagerDelegate, CBCentralManagerDelegate>

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
        //  初始化beacon管理者
        _beaconManager = [[ABBeaconManager alloc] init];
        //  设置beacon管理者的代理
        _beaconManager.delegate = self;
        
        // 初始化蓝牙管理者
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
    IOTabBarController *tabBarVC = [[IOTabBarController alloc] init];
    [IORootTool changeRootViewControllerTo:tabBarVC];
    
    // 检测蓝牙状态
    // 不可用就提示用户开启蓝牙并授权
    NSString *message = nil;
    UIAlertAction *rightAction = nil;
    
    switch (self.centralManager.state) {
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
            
            // CBManagerStateUnauthorized 蓝牙未授权，请求用户授权
            case 3:
            message = @"设备尚未授权iOrder使用您的蓝牙，为了方便您点餐，请同意授权。";
            rightAction = [UIAlertAction actionWithTitle:@"去授权" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
            }];
            break;
            
            // CBManagerStatePoweredOff 未打开蓝牙，提示用户去打开
            case 4:
            message = @"设备尚未打开蓝牙，请打开您的蓝牙。";
            rightAction = [UIAlertAction actionWithTitle:@"去打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                     
                    if([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
            }];
            break;
            
            // CBManagerStatePoweredOn 蓝牙可用且已授权，则开始监听
            case 5:
            [self startMonitoringForRegion];
            break;
            
        default:
            break;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    if (rightAction) {
        [alert addAction:rightAction];
    }
    
    [tabBarVC presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 开始监听区域
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
    } else {    // region有值就先停掉之前的
        [self.beaconManager stopMonitoringForRegion:self.region];
    }
    IOLog(@"self.region = %@", self.region);
    [self.beaconManager startMonitoringForRegion:self.region];
    IOLog(@"开始监控");
}

#pragma mark - ABBeaconManagerDelegate
- (void)beaconManager:(ABBeaconManager *)manager monitoringDidFailForRegion:(ABBeaconRegion *)region withError:(NSError *)error {
    IOLog(@"manager = %@, region = %@, error = %@", manager, region, error);
}

- (void)beaconManager:(ABBeaconManager *)manager didEnterRegion:(ABBeaconRegion *)region {
    isInRegion = YES;
    IOLog(@"进入区域了");
    NSString *contentBody = [NSString localizedUserNotificationStringForKey:@"欢迎进入点餐区域！"
                                                                  arguments:nil];
    
    [self pushNotificationWithContentBody:contentBody identifier:@"EnterRegion"];
}

- (void)beaconManager:(ABBeaconManager *)manager didExitRegion:(ABBeaconRegion *)region {
    isInRegion = NO;
    IOLog(@"退出区域了");
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

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    IOLog(@"%s--开始检测蓝牙", __func__);
    NSString *message = nil;
    switch (central.state) {
            case 1:
            message = @"该设备不支持蓝牙功能,请检查系统设置";
            break;
            
            case 2:
            message = @"设备不支持蓝牙，请您去前台点餐。";
            break;
            
            case 3:
            message = @"设备尚未授权iOrder使用您的蓝牙，为了方便您点餐，请同意授权。";
            break;
            
            case 4:
            message = @"设备尚未打开蓝牙，为了方便您点餐，,请打开蓝牙。";
            break;
            
            case 5:
            message = @"蓝牙已经成功开启";
            break;
            
        default:
            break;
    }
    
    if (message && message.length != 0) {
        IOLog(@"message == %@",message);
    }
}

@end
