//
//  YWJShoppingCartParam.h
//  iOrder
//
//  Created by 易无解 on 5/29/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJShoppingCartParam : NSObject

/**
 用户id
 */
@property (nonatomic, assign) NSInteger userId;

/**
 菜品id
 */
@property (nonatomic, assign) NSInteger dishesId;

/**
 点菜的数量
 */
@property (nonatomic, assign) NSInteger amount;

@end
