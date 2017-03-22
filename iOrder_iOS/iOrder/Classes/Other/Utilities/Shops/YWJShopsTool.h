//
//  YWJShopsTool.h
//  iOrder
//
//  Created by 易无解 on 5/9/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJShopsTool : NSObject

/**
 *  请求商店的数据
 *
 *  @param success 请求成功的时候回调(shops(IOShops模型))
 *  @param failure 请求失败的时候回调，错误传递给外界
 */
+ (void)newShopsSuccess:(void(^)(NSArray *shops))success failure:(void(^)(NSError *error))failure;

@end
