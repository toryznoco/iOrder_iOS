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
 Get请求

 @param URLString URL
 @param parameters 参数
 @param success 请求成功时的回调
 @param failure 请求失败时的回调
 @return dataTask
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

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
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

@end
