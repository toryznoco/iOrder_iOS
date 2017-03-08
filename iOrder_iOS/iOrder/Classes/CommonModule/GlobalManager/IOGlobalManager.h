//
//  IOGlobalManager.h
//  iOrder
//
//  Created by Tory on 07/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface IOGlobalManager : NSObject 

/** App管理者的单例 */
Singleton_interface(Manager)

/** 进入App */
- (void)enterApp;

/** 开始监听指定区域 */
- (void)startMonitoringForRegion;

@end
