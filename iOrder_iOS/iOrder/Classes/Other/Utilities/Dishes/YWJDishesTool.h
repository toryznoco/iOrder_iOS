//
//  YWJDishesTool.h
//  iOrder
//
//  Created by 易无解 on 5/10/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJDishesTool : NSObject

/**
 *  请求商店内所有菜的数据
 *
 *  @param success 请求成功的时候回调
 *  @param failure 请求失败的时候回调，错误传递给外界
 */
+ (void)newShopDishesWithShopId:(NSInteger)shopId Success:(void(^)(NSArray *shops))success failure:(void(^)(NSError *error))failure;

@end
