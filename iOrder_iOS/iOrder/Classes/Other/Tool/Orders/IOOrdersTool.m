//
//  IOOrdersTool.m
//  iOrder
//
//  Created by Tory on 16/5/28.
//  Copyright © 2016年 normcore. All rights reserved.
//

#import "IOOrdersTool.h"
#import "IOHttpTool.h"
#import "IOOrderResult.h"
#import "IOOrdersParam.h"

#import "MJExtension.h"

@implementation IOOrdersTool

+ (void)newOrdersSuccess:(void(^)(NSArray *orders))success failure:(void(^)(NSError *error))failure {
    
    //创建参数模型
    IOOrdersParam *param = [[IOOrdersParam alloc] init];
    param.userId = 1;
    
    [IOHttpTool GET:@"http://normcore.net.cn/iorder/server/user!getOrders.action" parameters:param.mj_keyValues success:^(id responseObject) {
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
