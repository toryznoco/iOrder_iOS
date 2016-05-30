//
//  YWJShoppingCartTool.m
//  iOrder
//
//  Created by 易无解 on 5/29/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJShoppingCartTool.h"

#import "YWJShoppingCartParam.h"
#import "IOHttpTool.h"
#import "MJExtension.h"

@implementation YWJShoppingCartTool

+ (void)addDishToShoppingCartWithUserId:(NSInteger)userId dishesId:(NSInteger)dishesId amount:(NSInteger)amount success:(void (^)())success failure:(void (^)(NSError *))failure {
    YWJShoppingCartParam *param = [[YWJShoppingCartParam alloc] init];
    param.userId = userId;
    param.dishesId = dishesId;
    param.amount = amount;
    YWJLog(@"%ld %ld %ld", param.userId, param.dishesId, param.amount);
    
    [IOHttpTool POST:@"http://normcore.net.cn/iorder/server/dishes!addToCart.action?" parameters:param.mj_keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)removeDishFromShoppingCartWithUserId:(NSInteger)userId dishesId:(NSInteger)dishesId amount:(NSInteger)amount success:(void (^)())success failure:(void (^)(NSError *))failure {
    YWJShoppingCartParam *param = [[YWJShoppingCartParam alloc] init];
    param.userId = userId;
    param.dishesId = dishesId;
    param.amount = amount;
    
    [IOHttpTool POST:@"http://normcore.net.cn/iorder/server/dishes!removeFromCart.action?" parameters:param success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
