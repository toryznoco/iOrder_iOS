//
//  IOOrdersManager.m
//  iOrder
//
//  Created by Tory on 24/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOOrdersManager.h"
#import "IONetworkTool.h"
#import "IOOrdersResult.h"
#import "IOError.h"

#define kIOHTTPOrderListUrl @"app/order/list"

@implementation IOOrdersManager

+ (void)loadNewOrdersSuccess:(void (^)(NSArray<IOOrder *> * _Nullable orders))success
                     failure:(void (^)(NSError * _Nonnull error))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPOrderListUrl];
    
    [IONetworkTool tokenGET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
        IOOrdersResult *result = [IOOrdersResult mj_objectWithKeyValues:responseObj];
        // 请求成功
        if (result.result == YES) {
            if (success) {
                success(result.orders);
            }
        } else {
            if (failure) {
                failure([IOError errorWithCode:result.code description:@"订单刷新失败"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
