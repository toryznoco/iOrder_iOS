//
//  IOOrder.h
//  iOrder
//
//  Created by Tory on 16/5/11.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOOrder : NSObject
/**
 *  店铺名称
 */
@property (nonatomic, copy) NSString *shopName;

/**
 *  订单状态
 */
@property (nonatomic, copy) NSString *orderState;

/**
 *  店铺图片url，不包含图片服务器根地址，需自行拼接
 */
@property (nonatomic, copy) NSString *shopIcon;

/**
 *  订单实付款
 */
@property (nonatomic, assign) float orderPayment;

/**
 *  时间
 */
@property (nonatomic, copy) NSString *time;

@end
