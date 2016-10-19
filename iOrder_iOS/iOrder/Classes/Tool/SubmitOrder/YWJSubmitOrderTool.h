//
//  YWJSubmitOrderTool.h
//  iOrder
//
//  Created by 易无解 on 5/30/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJSubmitOrderTool : NSObject

/**
 提交订单数据

 @param userId   用户id
 @param shopId   商店id
 @param couponId 优惠券id
 @param success  提交成功时的返回结果
 @param failure  提交失败时的返回结果
 */
+ (void)submitOrderWithUserId:(NSInteger)userId shopId:(NSInteger)shopId couponId:(NSInteger)couponId success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
