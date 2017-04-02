//
//  IONetworkTool.m
//  iOrder
//
//  Created by Tory on 22/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IONetworkTool.h"
#import "AFNetworking.h"
#import "IOAccountTool.h"
#import "IOError.h"
#import "IOAccessTokenResult.h"

#define kIOHTTPAccessTokenUrl @"app/customer/token"
extern BOOL ifNeededRefreshAccessToken;
@implementation IONetworkTool

/**
 Starts monitoring for changes in network reachability status.
 */
+ (void)startMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/**
 Stops monitoring for changes in network reachability status.
 */
+ (void)stopMonitoring {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


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
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    return [mgr GET:URLString parameters:parameters progress:nil success:success failure:failure];
}

/**
 Get请求带accessToken
 先判断accessToken，未过期就正常请求，accessToken放在了请求头中
 过期则请求刷新accessToken再请求数据
 
 @param URLString URL
 @param parameters 参数
 @param success 请求成功时的回调
 @param failure 请求失败时的回调
 @return dataTask
 */
+ (NSURLSessionDataTask *)tokenGET:(NSString *)URLString
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
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    __block BOOL ifSaveAccessTokenSucceed = NO;
    
    // 检查token是否有效
    if ([IOAccountTool checkIfAccessTokenValid]) {
        // token有效，在请求头中带上token发送请求
        [mgr.requestSerializer setValue:[IOAccountTool accessToken] forHTTPHeaderField:@"token"];
        // 用AFNetworking发送请求
        return [mgr GET:URLString parameters:parameters progress:nil success:success failure:failure];
        
    } else {
        // 创建信号量
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            // token无效，则请求刷新token
            NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPAccessTokenUrl];
            
            [mgr POST:urlStr parameters:[IOAccountTool refreshToken] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                IOAccessTokenResult *result = [IOAccessTokenResult mj_objectWithKeyValues:responseObject];
                if (result.result) {
                    // 保存accessToken
                    [IOAccountTool saveAccessToken:result.accessToken validTime:result.accessTokenTTL];
                    ifSaveAccessTokenSucceed = YES;
                } else {
                    IOLog(@"token刷新失败，%@", result.message);
                    if (failure) {
                        failure(nil, [IOError errorWithCode:result.code description:result.message]);
                    }
                }
                dispatch_semaphore_signal(sema);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                IOLog(@"%@", error);
                if (failure) {
                    failure(task, error);
                }
                dispatch_semaphore_signal(sema);
            }];
        });
        // 等待信号量变为1再继续请求数据
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        if (ifSaveAccessTokenSucceed) {
            // 用新的acccessToken请求数据
            [mgr.requestSerializer setValue:[IOAccountTool accessToken] forHTTPHeaderField:@"token"];
            // 用AFNetworking发送请求
            return [mgr GET:URLString parameters:parameters progress:nil success:success failure:failure];
        }
        return nil;
    }
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
        IOLog(@"%ld", [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
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

/**
 发送格式为JSON的POST请求
 
 @param URLString url
 @param parameters 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return dataTask
 */
+ (NSURLSessionDataTask *)JSONPOST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObj))success
                           failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    
    // 检查网络是否可用
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        IOLog(@"%ld", [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
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
