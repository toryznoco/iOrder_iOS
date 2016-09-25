//
//  AppDelegate.h
//  iOrder
//
//  Created by 易无解 on 3/25/16.
//  Copyright © 2016 易无解. All rights reserved.
//  

#import <UIKit/UIKit.h>

#import <AprilBeaconSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, ABBeaconManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 *  beacon的管理者
 */
@property (nonatomic, strong) ABBeaconManager *beaconManager;

@end

