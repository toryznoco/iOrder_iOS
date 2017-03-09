//
//  YWJShoppingCartTool.h
//  iOrder
//
//  Created by 易无解 on 5/29/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YWJShoppingCartInfoResult;

@interface YWJShoppingCartTool : NSObject

/**
 添加选好的菜品到购物车中

 @param userId   用户id
 @param dishesId 菜品id
 @param amount   菜品数量
 @param success  成功添加到购物车时的返回参数
 @param failure  失败添加到购物车时的返回参数
 */
+ (void)addDishToShoppingCartWithUserId:(NSInteger)userId dishesId:(NSInteger)dishesId amount:(NSInteger)amount success:(void(^)())success failure:(void(^)(NSError *error))failure;

/**
 移除购物车中的菜品

 @param userId   用户id
 @param dishesId 菜品id
 @param amount   菜品数量
 @param success  成功移除购物车中的菜品时
 @param failure  失败移除购物车中的菜品时
 */
+ (void)removeDishFromShoppingCartWithUserId:(NSInteger)userId dishesId:(NSInteger)dishesId amount:(NSInteger)amount success:(void(^)())success failure:(void(^)(NSError *error))failure;

/**
 *  请求商店内所有菜的数据
 *
 *  @param success 请求成功的时候回调
 *  @param failure 请求失败的时候回调，错误传递给外界
 */
+ (void)newShoppingCartInfosWithUserId:(NSInteger)userId shopId:(NSInteger)shopId Success:(void(^)(YWJShoppingCartInfoResult *shoppingCartInfos))success failure:(void(^)(NSError *error))failure;

@end
