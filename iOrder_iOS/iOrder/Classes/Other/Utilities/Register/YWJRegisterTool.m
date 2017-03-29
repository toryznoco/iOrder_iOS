//
//  YWJRegisterTool.m
//  iOrder
//
//  Created by 易无解 on 22/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "YWJRegisterTool.h"

#import "YWJRegisterResult.h"
#import "IONetworkTool.h"
#import "IOHttpTool.h"

@implementation YWJRegisterTool

+ (void)registerWithParam:(id)param success:(void (^)(YWJRegisterResult *))success failure:(void (^)(NSError *))failure {
    //1.获取URL
    NSString *urlString = [NSString stringWithFormat:@"%@app/customer/register", kBackStageServerPath];
    
    //2.发送post请求
//    [IONetworkTool POST:urlString parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
//        YWJRegisterResult *result = [YWJRegisterResult mj_objectWithKeyValues:responseObj];
//        if (success) {
//            success(result);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    [IOHttpTool JSONPOST:urlString parameters:param success:^(id responseObject) {
        YWJRegisterResult *result = [YWJRegisterResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
