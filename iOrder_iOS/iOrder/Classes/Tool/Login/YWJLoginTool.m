//
//  YWJLoginTool.m
//  iOrder
//
//  Created by 易无解 on 8/18/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJLoginTool.h"

#import "IOHttpTool.h"
#import "YWJLoginParam.h"
#import "YWJLoginResult.h"
#import "MJExtension.h"

#import "YWJCacheTool.h"

@implementation YWJLoginTool

+ (void)loginWithLoginParam:(YWJLoginParam *)loginParam success:(void (^)(YWJLoginResult *))success failure:(void (^)(NSError *))failure {
    NSString *urlString = [NSString stringWithFormat:@"%@user!login.action", kBackStageServerPath];
    
    //先从数据库获取数据
    YWJLoginResult *loginResult = [YWJCacheTool loginResultWithLoginParam:loginParam];
    if (loginResult) {//获取成功
        if (success) {
            success(loginResult);
        }
        return ;
    } else {//获取失败
        [IOHttpTool GET:urlString parameters:loginParam.mj_keyValues success:^(id responseObject) {
            YWJLoginResult *result = [YWJLoginResult mj_objectWithKeyValues:responseObject];
            if (success) {
                success(result);
            }
            //        保存到数据库
            [YWJCacheTool saveUserInfoWithLoginParam:loginParam andLoginResult:result];
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
