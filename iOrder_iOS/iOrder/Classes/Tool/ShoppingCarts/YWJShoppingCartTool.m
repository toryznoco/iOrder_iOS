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

+ (void)addDishToShoppingCartWithUserId:(NSInteger)userId dishesId:(NSInteger)dishesId amount:(NSInteger)amount success:(void (^)())success failure:(void (^)(NSError *))failure{
    YWJShoppingCartParam *param = [[YWJShoppingCartParam alloc] init];
    param.userId = userId;
    param.dishsId = dishesId;
    param.amount = amount;
    YWJLog(@"%ld %ld %ld", param.userId, param.dishsId, param.amount);
    
    [IOHttpTool POST:@"http://normcore.net.cn/iorder/server/dishes!addToCart.action?" parameters:param.mj_keyValues success:^(id responseObject) {
        YWJLog(@"nimeide 成功");
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        YWJLog(@"nimeide 失败");
        if (failure) {
            failure(error);
        }
    }];
}

@end
