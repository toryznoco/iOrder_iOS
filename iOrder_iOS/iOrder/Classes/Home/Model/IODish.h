//
//  IODish.h
//  iOrder
//
//  Created by 易无解 on 4/30/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface IODish : NSObject<MJKeyValue>

/**
 *  菜的图标
 */
@property (nonatomic, copy) NSString *dishIcon;

/**
 *  菜的名称
 */
@property (nonatomic, copy) NSString *dishName;

/**
 *  菜的销售量
 */
@property (nonatomic, copy) NSString *dishSalesCount;

/**
 *  菜获取的赞
 */
@property (nonatomic, copy) NSString *dishFollow;

/**
 *  菜的价格
 */
@property (nonatomic, copy) NSString *dishPrice;

@end
