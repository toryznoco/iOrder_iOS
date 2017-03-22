//
//  IOHttpTool.h
//  iOrder
//
//  Created by 易无解 on 5/9/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOHttpTool : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求数据的URL
 *  @param parameters 请求数据所需要的参数
 *  @param success    当请求数据成功时，需要回调的代码
 *  @param failure    当请求数据失败时，需要回调的代码
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 发送post请求

 @param URLString  请求数据的URL
 @param parameters 请求数据所需的参数
 @param success    当请求数据成功时，需要回调的代码
 @param failure    当请求数据失败时，需要回调的代码
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end

