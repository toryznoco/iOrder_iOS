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

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
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
    return [mgr GET:URLString parameters:parameters progress:nil success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
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
    return [mgr POST:URLString parameters:parameters progress:nil success:success failure:failure];
}

@end
