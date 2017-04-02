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
#import "IOPayOrderParam.h"
#import "IOGetDishParam.h"

#define kIOHTTPOrderListUrl @"app/order/list"
#define kIOHTTPPayOrderUrl @"app/order/pay"
#define kIOHTTPGetDishUrl @"app/order/take"

@implementation IOOrdersManager

/**
 获取订单列表
 
 @param success 成功的回调
 @param failure 失败的回调
 */
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

/**
 支付订单
 
 @param param 订单id
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)payOrder:(IOPayOrderParam *)param success:(void (^)(IOHTTPBaseResult * _Nullable result))success
         failure:(void (^)(NSError * _Nonnull error))failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPPayOrderUrl];
    
    [IONetworkTool tokenPOST:urlStr parameters:param.mj_keyValues success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
        IOHTTPBaseResult *result = [IOHTTPBaseResult mj_objectWithKeyValues:responseObj];
        // 请求成功
        if (result.result == YES) {
            if (success) {
                success(result);
            }
        } else {
            if (failure) {
                failure([IOError errorWithCode:result.code description:@"支付订单失败"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 取餐
 
 @param param 订单id
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)getDish:(IOGetDishParam *)param success:(void (^)(IOHTTPBaseResult * _Nullable result))success
        failure:(void (^)(NSError * _Nonnull error))failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPGetDishUrl];
    
    [IONetworkTool tokenPOST:urlStr parameters:param.mj_keyValues success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
        IOHTTPBaseResult *result = [IOHTTPBaseResult mj_objectWithKeyValues:responseObj];
        // 请求成功
        if (result.result == YES) {
            if (success) {
                success(result);
            }
        } else {
            if (failure) {
                failure([IOError errorWithCode:result.code description:@"取餐失败"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
