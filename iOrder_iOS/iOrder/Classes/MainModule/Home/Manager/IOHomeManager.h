//
//  IOHomeManager.h
//  iOrder
//
//  Created by Tory on 29/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IOLoginResult, IODishesResult, IOShoppingCartParam, IOShoppingCartResult, IOShoppingCartAddParam, IOShoppingCartAddResult, IOShoppingCartDropParam, IOShoppingCartDropResult, IOOrderGenerateParam, IOOrderGenerateResult;

@interface IOHomeManager : NSObject

/**
 刷新本地存储的accessToken和refreshToken
 
 @param success 刷新成功的回调
 @param failure 刷新失败的回调
 */
+ (void)refreshTokenSuccess:(void (^_Nullable)())success
                    failure:(void (^_Nullable)(NSError * _Nonnull error))failure;

/**
 获取附近店铺信息
 
 @param success 获取成功的回调
 @param failure 获取失败的回调
 */
+ (void)loadNearbyShopsSuccess:(void(^_Nullable)(NSArray * _Nullable shops))success failure:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 *  请求商店内所有菜的数据
 *
 *  @param success 请求成功的时候回调
 *  @param failure 请求失败的时候回调，错误传递给外界
 */
+ (void)loadShopDishesWithShopId:(NSInteger)shopId Success:(void(^_Nullable)(IODishesResult * _Nullable dishesResult))success failure:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 *  请求商店内所有菜的数据
 *
 *  @param shopId 店铺的id
 *  @param success 请求成功的时候回调
 *  @param failure 请求失败的时候回调，错误传递给外界
 */
+ (void)loadShoppingCartInfosWithShopId:(IOShoppingCartParam *_Nullable)param Success:(void(^_Nullable)(IOShoppingCartResult * _Nullable result))success failure:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 *  添加选好的菜品到购物车中
 *
 *  @param param    添加选好的菜品的参数
 *  @param success  成功添加到购物车时的返回参数
 *  @param failure  失败添加到购物车时的返回参数
 */
+ (void)addDishToShoppingCartWithParam:(IOShoppingCartAddParam *_Nullable)param success:(void(^_Nullable)(IOShoppingCartAddResult * _Nullable result))success failure:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 *  移除购物车中的菜品
 *
 *  @param param    移除购物车中的菜品的参数
 *  @param success  成功移除购物车中的菜品时
 *  @param failure  失败移除购物车中的菜品时
 */
+ (void)dropDishFromShoppingCartWithParam:(IOShoppingCartDropParam *_Nullable)param success:(void(^_Nullable)(IOShoppingCartDropResult * _Nullable result))success failure:(void(^_Nullable)(NSError * _Nullable error))failure;

/**
 *  提交订单数据
 *
 *  @param param    请求参数
 *  @param success  提交成功时的返回结果
 *  @param failure  提交失败时的返回结果
 */
+ (void)submitOrderWithParam:(IOOrderGenerateParam *_Nullable)param success:(void(^_Nullable)(IOOrderGenerateResult * _Nullable result))success failure:(void(^_Nullable)(NSError * _Nullable error))failure;

@end
