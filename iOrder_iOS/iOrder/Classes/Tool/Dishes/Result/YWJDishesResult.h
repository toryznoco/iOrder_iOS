//
//  YWJDishesResult.h
//  iOrder
//
//  Created by 易无解 on 5/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface YWJDishesResult : NSObject<MJKeyValue>

/**
 *  商铺菜品分类和菜品列表
 */
@property (nonatomic, strong) NSArray *shopDishes;

@end
