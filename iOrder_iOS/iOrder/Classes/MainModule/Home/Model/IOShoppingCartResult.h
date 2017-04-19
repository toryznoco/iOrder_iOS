//
//  IOShoppingCartResult.h
//  iOrder
//
//  Created by 易无解 on 05/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseResult.h"

@class IODish;

@interface IOShoppingCartResult : IOHTTPBaseResult<MJKeyValue>

/** 所有订单项的总金额 */
@property (nonatomic, assign) CGFloat totalPrice;

/** 订单项列表 */
@property (nonatomic, strong) NSMutableArray *items;

@end

@interface IOShoppingCartItem : IOHTTPBaseResult<MJKeyValue>

/** 订单项ID */
@property (nonatomic, assign) NSInteger itemId;

/** 商品数量 */
@property (nonatomic, assign) NSInteger amount;

/** 评论内容 */
@property (nonatomic, assign) NSInteger comment;

/** 评论时间，精确到毫秒的时间戳 */
@property (nonatomic, assign) NSInteger commentTime;

/** 评星，1-5 */
@property (nonatomic, assign) NSInteger score;

/** 订单项总金额 */
@property (nonatomic, assign) CGFloat totalPrice;

/** 订单项商品信息 */
@property (nonatomic, strong) IODish *goods;

@end
