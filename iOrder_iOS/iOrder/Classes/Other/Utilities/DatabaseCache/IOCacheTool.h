//
//  IOCacheTool.h
//  iOrder
//
//  Created by 易无解 on 9/21/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IOLoginParam, IOLoginResult, IONearbyShopsParam, IONearbyShopsResult;

@interface IOCacheTool : NSObject

#pragma mark - UserInfo
/**
 *  保存登录时的账号和密码及返回的相关信息
 *
 *  @param loginParam 登录时的账号和密码
 */
+ (void)saveUserInfoWithLoginParam:(IOLoginParam *)param andLoginResult:(IOLoginResult *)result;
/**
 *  返回用户信息
 *
 *  @param param 用户账号和密码
 *
 *  @return 用户所有信息
 */
+ (IOLoginResult *)loginResultWithLoginParam:(IOLoginParam *)param;


#pragma mark - ShopInfo
/**
 *  保存所有商店的参数及相关信息
 *
 *  @param param  获取商店信息的参数
 *  @param result 商店信息
 */
+ (void)saveShopInfoWithShopParam:(IONearbyShopsParam *)param andShopResult:(id)result;
/**
 *  返回所有商店信息
 *
 *  @param param 获取商店信息的参数
 *
 *  @return 商店信息
 */
+ (IONearbyShopsResult *)shopResultWithShopParam:(IONearbyShopsParam *)param;

@end
