//
//  YWJSubmitOrderTool.m
//  iOrder
//
//  Created by 易无解 on 5/30/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJSubmitOrderTool.h"

#import "YWJSubmitOrderParam.h"
#import "IOHttpTool.h"
#import "MJExtension.h"

@implementation YWJSubmitOrderTool

+ (void)submitOrderWithUserId:(NSInteger)userId shopId:(NSInteger)shopId couponId:(NSInteger)couponId success:(void (^)())success failure:(void (^)(NSError *))failure {
    YWJSubmitOrderParam *param = [[YWJSubmitOrderParam alloc] init];
    param.userId = userId;
    param.shopId = shopId;
    param.couponId = couponId;
    
    [IOHttpTool POST:@"http://normcore.net.cn/iorder/server/dishes!order.action?" parameters:param.mj_keyValues success:^(id responseObject) {
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
