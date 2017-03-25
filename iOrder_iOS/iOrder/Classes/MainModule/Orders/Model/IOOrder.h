//
//  IOOrder.h
//  iOrder
//
//  Created by Tory on 16/5/11.
//  Copyright © 2016年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 订单状态
typedef NS_ENUM(NSUInteger, IOOrderStatus){
    IOOrderStatusCancel = 0,    ///<已取消
    IOOrderStatusSubmited,      ///<待支付
    IOOrderStatusPaid,          ///<待接单
    IOOrderStatusCooking,       ///<待通知取餐
    IOOrderStatusCooked,        ///<待取餐
    IOOrderStatusReceipt,      ///<待评价
    IOOrderStatusDone,          ///<已完成
};

@interface IOOrder : NSObject
/**
 *  餐厅ID
 */
@property (nonatomic, assign) NSString *shopId;

/**
 *  餐厅名字
 */
@property (nonatomic, copy) NSString *shopName;

/**
 *  订单状态
 */
@property (nonatomic, assign) IOOrderStatus status;

/**
 *  店铺图片url，不包含图片服务器根地址，需自行拼接
 */
@property (nonatomic, copy) NSString *shopPic;

/**
 *  菜品数量
 */
@property (nonatomic, assign) int dishesAmt;

/**
 *  订单金额
 */
@property (nonatomic, assign) double price;

/**
 *  下单时间
 */
@property (nonatomic, copy) NSString *orderTime;

@end
