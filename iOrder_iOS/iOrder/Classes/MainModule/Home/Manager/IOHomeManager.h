//
//  IOHomeManager.h
//  iOrder
//
//  Created by Tory on 29/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IOLoginResult, IODishesResult;

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


@end
