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
 *  餐厅ID
 */
@property (nonatomic, assign) int *shopId;

/**
 *  餐厅名字
 */
@property (nonatomic, copy) NSString *shopName;

/**
 *  菜品数量
 */
@property (nonatomic, assign) int dishesAmt;

/**
 *  订单状态
 */
@property (nonatomic, copy) NSString *status;

/**
 *  店铺图片url，不包含图片服务器根地址，需自行拼接
 */
@property (nonatomic, copy) NSString *shopIcon;

/**
 *  订单金额
 */
@property (nonatomic, assign) float price;

/**
 *  下单时间
 */
@property (nonatomic, copy) NSString *time;

@end
