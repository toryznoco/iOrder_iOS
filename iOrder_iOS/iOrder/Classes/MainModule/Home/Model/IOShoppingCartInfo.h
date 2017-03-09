//
//  IOShoppingCartInfo.h
//  iOrder
//
//  Created by 易无解 on 6/1/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

#pragma mark - interface IOShoppingCartInfo
@interface IOShoppingCartInfo : NSObject<MJKeyValue>

/**
 *  总金额，两位小数
 */
@property (nonatomic, assign) CGFloat totalPri;
/**
 *  数组
 */
@property (nonatomic, strong) NSMutableArray *itmes;

@end


@interface IOShoppingCartDishesInfo : NSObject<MJKeyValue>

/**
 *  菜品名称
 */
@property (nonatomic, copy) NSString *dishesName;
/**
 *  条目金额，两位小数
 */
@property (nonatomic, assign) CGFloat itemPrice;
/**
 *  条目菜品数量
 */
@property (nonatomic, assign) NSInteger amount;

@end
