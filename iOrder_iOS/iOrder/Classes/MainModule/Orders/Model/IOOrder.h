//
//  IOOrder.h
//  iOrder
//
//  Created by Tory on 16/5/11.
//  Copyright © 2016年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOShop.h"

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
/** 订单ID */
@property (nonatomic, assign) NSInteger orderId;
/** 店铺信息 */
@property (nonatomic, strong) IOShop *shop;
/** 订单状态 */
@property (nonatomic, assign) IOOrderStatus status;
/** 菜品数量 */
@property (nonatomic, assign) int goodsAmount;
/** 订单金额 */
@property (nonatomic, assign) float totalPrice;
/** 下单时间 */
@property (nonatomic, copy) NSString *orderTime;

@end
