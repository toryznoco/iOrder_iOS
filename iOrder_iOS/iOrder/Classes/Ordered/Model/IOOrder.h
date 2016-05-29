//
//  IOOrder.h
//  iOrder
//
//  Created by Tory on 16/5/11.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 订单状态
typedef NS_ENUM(NSUInteger, IOOrderState){
    IOOrderStateCancel = 0, ///<订单取消
    IOOrderStateSubmited,   ///<待支付
    IOOrderStatePaid,       ///<待接单
    IOOrderStateCooking,    ///<待配餐
    IOOrderStateCooked,     ///<待取餐
    IOOrderStateDone,       ///<待评价
    IOOrderStateCompleted,  ///<订单完成
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
@property (nonatomic, assign) IOOrderState status;

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
@property (nonatomic, assign) float price;

/**
 *  下单时间
 */
@property (nonatomic, copy) NSString *time;

@end
