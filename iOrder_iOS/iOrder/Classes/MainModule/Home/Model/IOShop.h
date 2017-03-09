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
 *  商铺综合评星，0-5，一位小数
 */
@property (nonatomic, assign) float score;

/**
 *  商铺距离，单位M
 */
@property (nonatomic, assign) int distance;

/**
 *  已售数量
 */
@property (nonatomic, assign) int toSal;

/**
 *  商铺名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  人均消费，即多少钱一人，两位小数
 */
@property (nonatomic, assign) float perPri;

/**
 *  商铺ID，唯一标识，后面用这个ID请求指定商铺菜品
 */
@property (nonatomic, assign) int shopId;

/**
 *  商铺当前优惠信息，或者商铺广告语
 */
@property (nonatomic, copy) NSString *cheap;

/**
 *  商铺图片url，不包含图片服务器根地址，需自行拼接
 */
@property (nonatomic, copy) NSString *picture;

@end
