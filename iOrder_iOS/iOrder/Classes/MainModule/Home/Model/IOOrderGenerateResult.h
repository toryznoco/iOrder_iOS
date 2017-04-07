//
//  IOOrderGenerateResult.h
//  iOrder
//
//  Created by 易无解 on 07/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseResult.h"

@class IOShop, IOOrderInfo;

@interface IOOrderGenerateResult : IOHTTPBaseResult<MJKeyValue>

/** 生成的订单信息 */
@property (nonatomic, strong) IOOrderInfo *order;

@end


@interface IOOrderInfo : NSObject<MJKeyValue>

/** 订单ID */
@property (nonatomic, assign) NSInteger orderId;

/** 订单编号 */
@property (nonatomic, copy) NSString *code;

/** 订单状态，0-已取消，1-已下单未支付，2-已支付待接单，3-已接单制作中，4-制作完成待取货，5-已取货待评价，6-已评价订单完成 */
@property (nonatomic, copy) NSString *status;

/** 下单时间 */
@property (nonatomic, assign) NSInteger orderTime;

/** 支付时间 */
@property (nonatomic, assign) NSInteger payTime;

/** 接单时间 */
@property (nonatomic, assign) NSInteger receiveTime;

/** 制作完成时间，精确到毫秒的时间戳 */
@property (nonatomic, assign) NSInteger completeTime;

/** 取货时间 */
@property (nonatomic, assign) NSInteger getTime;

/** 取消订单时间 */
@property (nonatomic, assign) NSInteger cancelTime;

/** 订单总金额 */
@property (nonatomic, assign) CGFloat totalPrice;

/** 订单支付金额 */
@property (nonatomic, assign) CGFloat payPrice;

/** 订单包含的商品总数量 */
@property (nonatomic, assign) NSInteger goodsAmount;

/** 订单所属店铺信息 */
@property (nonatomic, strong) IOShop *shop;

@end
