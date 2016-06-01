//
//  YWJShoppingCartTool.h
//  iOrder
//
//  Created by 易无解 on 5/29/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YWJShoppingCartInfoResult;

@interface YWJShoppingCartTool : NSObject

+ (void)addDishToShoppingCartWithUserId:(NSInteger)userId dishesId:(NSInteger)dishesId amount:(NSInteger)amount success:(void(^)())success failure:(void(^)(NSError *error))failure;

+ (void)removeDishFromShoppingCartWithUserId:(NSInteger)userId dishesId:(NSInteger)dishesId amount:(NSInteger)amount success:(void(^)())success failure:(void(^)(NSError *error))failure;

/**
 *  请求商店内所有菜的数据
 *
 *  @param success 请求成功的时候回调
 *  @param failure 请求失败的时候回调，错误传递给外界
 */
+ (void)newShoppingCartInfosWithUserId:(NSInteger)userId shopId:(NSInteger)shopId Success:(void(^)(YWJShoppingCartInfoResult *shoppingCartInfos))success failure:(void(^)(NSError *error))failure;

@end
