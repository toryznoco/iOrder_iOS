//
//  IORegisterManager.m
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IORegisterManager.h"
#import "IORegisterParam.h"
#import "IORegisterResult.h"
#import "IONetworkTool.h"

#define kIOHTTPRegisterUrl @"app/customer/register"

@implementation IORegisterManager

/**
 *  注册账号所返回的情况
 *
 *  @param param 注册请求参数
 *  @param success    注册请求成功的时候的回调
 *  @param failure    注册请求失败的时候的回调
 */
+ (void)registerWithParam:(id)param success:(void (^)(IORegisterResult * _Nullable))success failure:(void (^)(NSError * _Nullable))failure {
    //1.获取URL
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPRegisterUrl];

    //2.发送json网络请求
    [IONetworkTool JSONPOST:urlString parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
        IORegisterResult *result = [IORegisterResult mj_objectWithKeyValues:responseObj];
        if (success) {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
