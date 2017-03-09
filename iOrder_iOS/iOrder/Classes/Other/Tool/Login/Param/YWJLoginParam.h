//
//  YWJLoginParam.h
//  iOrder
//
//  Created by 易无解 on 8/18/16.
//  Copyright © 2016 normcore. All rights reserved.
//  用户参数模型

#import <Foundation/Foundation.h>

@interface YWJLoginParam : NSObject


/**
 用户名
 */
@property (nonatomic, copy) NSString *userName;

/**
 用户密码
 */
@property (nonatomic, copy) NSString *userPass;

@end
