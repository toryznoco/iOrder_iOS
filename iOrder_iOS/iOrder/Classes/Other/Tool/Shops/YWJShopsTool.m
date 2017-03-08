//
//  YWJShopsTool.m
//  iOrder
//
//  Created by 易无解 on 5/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJShopsTool.h"

#import "YWJShopsParam.h"
#import "YWJShopsResult.h"
#import "IOHttpTool.h"

#import "MJExtension.h"
#import "YWJCacheTool.h"

@implementation YWJShopsTool

+ (void)newShopsSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    //创建参数模型
    YWJShopsParam *param = [[YWJShopsParam alloc] init];
    param.startId = 0;
    param.amount = 10;
    param.userLng = 30.59;
    param.userLat = 103.59;
    //先从数据库获取数据
    YWJShopsResult *shopsResult = [YWJCacheTool shopResultWithShopParam:param];
    if (shopsResult) {
        if (success) {
            success(shopsResult.shops);
        }
        return ;
    } else {
        [IOHttpTool GET:@"http://normcore.net.cn/iorder/server/shop!getNearestShops.action" parameters:param.mj_keyValues success:^(id responseObject) {
            //字典转模型
            YWJShopsResult *result = [YWJShopsResult mj_objectWithKeyValues:responseObject];
            if (success) {
                success(result.shops);
            }
            //        保存到数据库
            [YWJCacheTool saveShopInfoWithShopParam:param andShopResult:responseObject];
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
