//
//  YWJLoginResult.h
//  iOrder
//
//  Created by 易无解 on 8/18/16.
//  Copyright © 2016 normcore. All rights reserved.
//  登录返回模型

#import <Foundation/Foundation.h>

#import "IOUser.h"

@interface YWJLoginResult : NSObject

/**
 判断用户是否登录成功，code为1，登录成功；为0，登录失败；
 */
@property (nonatomic, assign) NSInteger code;

/**
 储存返回的用户信息模型
 */
@property (nonatomic, strong) IOUser *user;

@end
