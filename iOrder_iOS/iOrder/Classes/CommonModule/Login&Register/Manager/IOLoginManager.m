//
//  IOLoginManager.m
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOLoginManager.h"
#import "IONetworkTool.h"
#import "IOLoginParam.h"
#import "IOLoginResult.h"

#define kIOHTTPLoginUrl @"app/customer/login"

@implementation IOLoginManager

/**
 登录
 
 @param param 参数
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)loginWithParam:(IOLoginParam *)param
               success:(void (^)(IOLoginResult * _Nullable result))success
               failure:(void (^)(NSError * _Nonnull error))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPLoginUrl];
    [IONetworkTool POST:urlStr parameters:param.mj_keyValues success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObj) {
        IOLoginResult *result = [IOLoginResult mj_objectWithKeyValues:responseObj];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
