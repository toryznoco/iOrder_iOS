//
//  YWJLoginTool.h
//  iOrder
//
//  Created by 易无解 on 8/18/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YWJLoginParam, YWJLoginResult;

@interface YWJLoginTool : NSObject

/**
 *  登录账号所返回的情况
 *
 *  @param loginParam 登录请求参数
 *  @param success    登录请求成功的时候的回调
 *  @param failure    登录请求失败的时候的回调
 */
+ (void)loginWithLoginParam:(YWJLoginParam *)loginParam success:(void(^)(YWJLoginResult *loginResult))success failure:(void(^)(NSError *error))failure;

@end
