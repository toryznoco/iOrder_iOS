//
//  IOOrdersTool.h
//  iOrder
//
//  Created by Tory on 16/5/28.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOOrdersTool : NSObject

/**
 *  请求订单数据
 *
 *  @param success 请求成功的时候回调(orders(IOOrder模型))
 *  @param failure 请求失败的时候回调，错误传递给外界
 */
+ (void)newOrdersSuccess:(void(^)(NSArray *orders))success failure:(void(^)(NSError *error))failure;

@end
