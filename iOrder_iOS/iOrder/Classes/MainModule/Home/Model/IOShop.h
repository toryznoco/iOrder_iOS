//
//  IOShop.h
//  iOrder
//
//  Created by 易无解 on 5/9/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface IOShop : NSObject<MJKeyValue>

/**
 *  商铺ID，唯一标识，后面用这个ID请求指定商铺菜品
 */
@property (nonatomic, assign) NSInteger shopId;

/**
 *  商铺名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  商铺地址
 */
@property (nonatomic, copy) NSString *address;

/**
 *  店铺所在位置经度
 */
@property (nonatomic, assign) CGFloat xCoord;

/**
 *  店铺所在位置纬度
 */
@property (nonatomic, assign) CGFloat yCoord;

/**
 *  商铺当前优惠信息，或者商铺广告语
 */
@property (nonatomic, copy) NSString *cheapInfo;

/**
 *  店铺销售总量
 */
@property (nonatomic, assign) NSInteger totalSale;

/**
 *  商铺图片url，不包含图片服务器根地址，需自行拼接
 */
@property (nonatomic, copy) NSString *picture;

/**
 *  店铺头像
 */
@property (nonatomic, copy) NSString *headImage;

/**
 *  人均消费，即多少钱一人，两位小数
 */
@property (nonatomic, assign) float personalPrice;

/**
 *  店铺详情页面背景图片
 */
@property (nonatomic, copy) NSString *detailBackImage;

/**
 *  商铺综合评星，0-5，最多一位小数
 */
@property (nonatomic, assign) float score;

/**
 *  每日开门时间
 */
@property (nonatomic, copy) NSString *openTime;

/**
 *  每日关门时间
 */
@property (nonatomic, copy) NSString *closeTime;

/**
 *  店铺电话
 */
@property (nonatomic, copy) NSString *phone;

/**
 *  店铺公告
 */
@property (nonatomic, copy) NSString *notice;

/**
 *  是否支持在线支付
 */
@property (nonatomic, assign) BOOL payOnline;

/**
 *  店铺距离，单位米
 */
@property (nonatomic, assign) NSInteger distance;

/**
 *  顾客今日是否已签到，此处无效
 */
@property (nonatomic, assign) BOOL todaySigned;

@end
