//
//  IOHomeManager.m
//  iOrder
//
//  Created by Tory on 29/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHomeManager.h"
#import "IONetworkTool.h"
#import "IOAccountTool.h"
#import "IOLoginResult.h"
#import "IOError.h"
#import "IOShop.h"
#import "IOError.h"
#import "IOCacheTool.h"
#import "IONearbyShopsResult.h"
#import "IONearbyShopsParam.h"
#import "IODishesParam.h"
#import "IODishesResult.h"
#import "IODishInfo.h"
#import "IOShoppingCartParam.h"
#import "IOShoppingCartResult.h"

#define kIOHTTPRefreshTokenUrl @"app/customer/refreshToken"
#define kIOHTTPNearbyShopsUrl @"app/shop/near"
#define kIOHTTPShopDishesUrl @"app/shop/goods"
#define kIOHTTPShoppingCartUrl @"app/order/cart"

@implementation IOHomeManager

/**
 刷新本地存储的accessToken和refreshToken
 
 @param success 刷新成功的回调
 @param failure 刷新失败的回调
 */
+ (void)refreshTokenSuccess:(void (^)())success failure:(void (^)(NSError * _Nonnull))failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPRefreshTokenUrl];
    NSDictionary *param = @{@"refreshToken": [IOAccountTool refreshToken]};
    
    [IONetworkTool POST:urlStr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
        IOLoginResult *result = [IOLoginResult mj_objectWithKeyValues:responseObj];
        IOLog(@"%@", result.message);
        if (result.result == YES) {
            // 请求成功
            // 保存accessToken及过期时间，refreshToken及过期时间
            [IOAccountTool saveAccessToken:result.accessToken validTime:result.accessTokenTTL];
            [IOAccountTool saveRefreshToken:result.refreshToken validTime:result.refreshTokenTTL];
            IOLog(@"%@", @"保存成功");
            
            if (success) {
                success();
            }
        } else {
            if (failure) {
                failure([IOError errorWithCode:result.code description:@"刷新失败"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 获取附近店铺信息
 
 @param success 获取成功的回调
 @param failure 获取失败的回调
 */
+ (void)loadNearbyShopsSuccess:(void (^)(NSArray * _Nullable))success failure:(void (^)(NSError * _Nullable))failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPNearbyShopsUrl];
    IONearbyShopsParam *param = [IONearbyShopsParam new];
    param.lng = 30.59;
    param.lat = 103.59;
    param.pageNum = 1;
    param.pageSize = 10;
    
    IONearbyShopsResult *shopsResult = [IOCacheTool shopResultWithShopParam:param];
    if (shopsResult) {
        if (success) {
            success(shopsResult.nearShops);
        }
        return ;
    } else {
        [IONetworkTool tokenGET:urlStr parameters:param.mj_keyValues success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
            IONearbyShopsResult *result = [IONearbyShopsResult mj_objectWithKeyValues:responseObj];
            if (result.result) {
                if (success) {
                    success(result.nearShops);
                }
                [IOCacheTool saveShopInfoWithShopParam:param andShopResult:responseObj];
            } else {
                IOLog(@"%@", result.message);
                if (failure) {
                    failure([IOError errorWithCode:result.code description:@"获取失败"]);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

/**
 *  请求商店内所有菜的数据
 *
 *  @param success 请求成功的时候回调
 *  @param failure 请求失败的时候回调，错误传递给外界
 */

+ (void)loadShopDishesWithShopId:(NSInteger)shopId Success:(void (^)(IODishesResult * _Nullable))success failure:(void (^)(NSError * _Nullable))failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPShopDishesUrl];
    IODishesParam *param = [[IODishesParam alloc] init];
    param.shopId = shopId;
    
    [IONetworkTool tokenGET:urlStr parameters:param.mj_keyValues success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
        IODishesResult *result = [IODishesResult mj_objectWithKeyValues:responseObj];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dic in result.goods) {
            IODish *dish = [IODish mj_objectWithKeyValues:dic];
            [tempArr addObject:dish];
        }
        result.goods = tempArr;
        NSMutableArray *tempArr1 = [NSMutableArray array];
        for (NSDictionary *dic in result.categories) {
            IODishCategory *category = [IODishCategory mj_objectWithKeyValues:dic];
            NSMutableArray *tempArr2 = [NSMutableArray array];
            for (NSDictionary *dic in category.goodsList) {
                IODish *dish = [IODish mj_objectWithKeyValues:dic];
                [tempArr2 addObject:dish];
            }
            category.goodsList = tempArr2;
            [tempArr1 addObject:category];
        }
        result.categories = tempArr1;
        if (success) {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  请求商店内所有菜的数据
 *
 *  @param shopId 店铺的id
 *  @param success 请求成功的时候回调
 *  @param failure 请求失败的时候回调，错误传递给外界
 */

+ (void)loadShoppingCartInfosWithShopId:(IOShoppingCartParam *)param Success:(void (^)(IOShoppingCartResult * _Nullable))success failure:(void (^)(NSError * _Nullable))failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPShoppingCartUrl];
    
    [IONetworkTool tokenGET:urlStr parameters:param.mj_keyValues success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
        IOShoppingCartResult *result = [IOShoppingCartResult mj_objectWithKeyValues:responseObj];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dic in result.items) {
            IOShoppingCartItem *item = [IOShoppingCartItem mj_objectWithKeyValues:dic];
            NSMutableArray *tempArr1 = [NSMutableArray array];
            for (NSDictionary *dic1 in item.goods) {
                IODish *dish = [IODish mj_objectWithKeyValues:dic1];
                [tempArr1 addObject:dish];
            }
            item.goods = tempArr1;
        }
        result.items = tempArr;
        
        if (success) {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
