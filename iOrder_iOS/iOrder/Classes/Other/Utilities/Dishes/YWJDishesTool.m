//
//  YWJDishesTool.m
//  iOrder
//
//  Created by 易无解 on 5/10/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "YWJDishesTool.h"

#import "YWJDishesParam.h"
#import "YWJDishesResult.h"
#import "IOHttpTool.h"

@implementation YWJDishesTool

+ (void)newShopDishesWithShopId:(int)shopId Success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    YWJDishesParam *param = [[YWJDishesParam alloc] init];
    param.shopId = shopId;
    
    [IOHttpTool GET:@"http://normcore.net.cn/iorder/server/shop!getShopDishesInfo.action" parameters:param.mj_keyValues success:^(id responseObject) {
        YWJDishesResult *result = [YWJDishesResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result.shopDishes);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
