//
//  IONetworkTool.h
//  iOrder
//
//  Created by Tory on 22/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IONetworkTool : NSObject

/**
 Starts monitoring for changes in network reachability status.
 */
+ (void)startMonitoring;

/**
 Stops monitoring for changes in network reachability status.
 */
+ (void)stopMonitoring;

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
                      failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

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
                      failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

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
                       failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;


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
                           failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

@end
