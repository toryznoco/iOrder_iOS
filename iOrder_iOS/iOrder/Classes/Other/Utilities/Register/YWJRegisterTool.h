//
//  YWJRegisterTool.h
//  iOrder
//
//  Created by 易无解 on 22/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YWJRegisterResult;

@interface YWJRegisterTool : NSObject

/**
 *  注册账号所返回的情况
 *
 *  @param param 注册请求参数
 *  @param success    注册请求成功的时候的回调
 *  @param failure    注册请求失败的时候的回调
 */
+ (void)registerWithParam:(id)param success:(void(^)(YWJRegisterResult *result))success failure:(void(^)(NSError *error))failure;

@end
