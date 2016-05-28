//
//  IOOrdersTool.m
//  iOrder
//
//  Created by Tory on 16/5/28.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOOrdersTool.h"
#import "IOHttpTool.h"
#import "IOOrderResult.h"

#import "MJExtension.h"

@implementation IOOrdersTool

+ (void)newOrdersSuccess:(void(^)(NSArray *orders))success failure:(void(^)(NSError *error))failure {
    [IOHttpTool GET:@"http://normcore.net.cn/iorder/server/user!getOrders.action?userId=1" parameters:nil success:^(id responseObject) {
        //字典转模型
        IOOrderResult *result = [IOOrderResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result.orders);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
