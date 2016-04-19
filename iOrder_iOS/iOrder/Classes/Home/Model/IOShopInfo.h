//
//  IOShopInfo.h
//  iOrder
//
//  Created by 易无解 on 4/18/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface IOShopInfo : NSObject<MJKeyValue>

/**
 *  店铺icon
 */
@property (nonatomic, copy) NSString *shopIcon;

/**
 *  店铺名称
 */
@property (nonatomic, copy) NSString *shopName;

/**
 *  店铺简介
 */
@property (nonatomic, copy) NSString *shopIntro;

/**
 *  店铺距离
 */
@property (nonatomic, copy) NSString *shopDistance;

/**
 *  店铺评价
 */
@property (nonatomic, copy) NSString *shopStar;

/**
 *  店铺人均价格
 */
@property (nonatomic, copy) NSString *shopPrice;

/**
 *  店铺销售量
 */
@property (nonatomic, copy) NSString *shopSaleCount;

@end
