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

/** 进入App时，根据情况选择根控制器 */
+ (void)chooseRootViewController;

/** 检测是否总是允许使用位置信息 */
+ (void)checkIfAllowAlwaysUseLocation;

/** 进入登录页面 */
- (void)enterLogin;

/** 进入主页 */
- (void)enterHome;

@end
