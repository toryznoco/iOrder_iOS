//
//  IOOrdersManager.h
//  iOrder
//
//  Created by Tory on 24/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IOOrder;
@class IOHTTPBaseResult;
@class IOPayOrderParam;
@class IOGetDishParam;

@interface IOOrdersManager : NSObject

/**
 获取订单列表

 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)loadNewOrdersSuccess:(void (^)(NSArray<IOOrder *> * _Nullable orders))success
                         failure:(void (^)(NSError * _Nonnull error))failure;

/**
 支付订单

 @param param 订单id
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)payOrder:(IOPayOrderParam *)param success:(void (^)(IOHTTPBaseResult * _Nullable result))success
                failure:(void (^)(NSError * _Nonnull error))failure;


/**
 取餐

 @param param 订单id
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)getDish:(IOGetDishParam *)param success:(void (^)(IOHTTPBaseResult * _Nullable result))success
        failure:(void (^)(NSError * _Nonnull error))failure;

@end
