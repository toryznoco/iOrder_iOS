//
//  IORegisterManager.h
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IORegisterParam;
@class IORegisterResult;

@interface IORegisterManager : NSObject

/**
 *  注册账号所返回的情况
 *
 *  @param param 注册请求参数
 *  @param success    注册请求成功的时候的回调
 *  @param failure    注册请求失败的时候的回调
 */
+ (void)registerWithParam:(id _Nullable )param success:(void(^_Nullable)(IORegisterResult * _Nullable result))success failure:(void(^_Nullable)(NSError * _Nullable error))failure;

@end
