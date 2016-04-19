//
//  IONotificationViewController.h
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AprilBeaconSDK.h"

@interface IONotificationViewController : UIViewController<ABBeaconManagerDelegate>

@property (nonatomic, strong) ABBeacon *beaconn;

@end
