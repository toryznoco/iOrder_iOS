//
//  IONetworkTool.m
//  iOrder
//
//  Created by Tory on 22/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IONetworkTool.h"
#import "AFNetworking.h"
#import "IOError.h"

@implementation IONetworkTool

/**
 Get请求
 
 @param URLString URL
 @param parameters 参数
 @param success 请求成功时的回调
 @param failure 请求失败时的回调
 @return dataTask
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObj))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure {
    // 检查网络是否可用
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        // 若不可用，则抛出错误
        if (failure) {
            failure(nil, [IOError errorWithCode:IOErrorCodeNetworkDisable description:kIOStringNetworkDisable]);
        }
        return nil;
    }
    
    // 用AFNetworking发送请求
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    return [mgr GET:URLString parameters:parameters progress:nil success:success failure:failure];
}

/**
 Post请求
 
 @param URLString URL
 @param parameters 参数
 @param success 请求成功时的回调
 @param failure 请求失败时的回调
 @return dataTask
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObj))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure {
    
    // 检查网络是否可用
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        // 若不可用，则抛出错误
        if (failure) {
            failure(nil, [IOError errorWithCode:IOErrorCodeNetworkDisable description:kIOStringNetworkDisable]);
        }
        return nil;
    }
     
    // 用AFNetworking发送请求
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    return [mgr POST:URLString parameters:parameters progress:nil success:success failure:failure];
}

@end
