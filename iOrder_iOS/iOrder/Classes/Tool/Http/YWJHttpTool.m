//
//  YWJHttpTool.m
//  iOrder
//
//  Created by 易无解 on 5/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJHttpTool.h"

#import "AFNetworking.h"

@implementation YWJHttpTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 发送get请求
    [mgr GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
