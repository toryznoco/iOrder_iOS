//
//  YWJLoginTool.m
//  iOrder
//
//  Created by 易无解 on 8/18/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "YWJLoginTool.h"

#import "IOHttpTool.h"
#import "YWJLoginParam.h"
#import "YWJLoginResult.h"
#import "MJExtension.h"

#import "IOCacheTool.h"

@implementation YWJLoginTool

+ (void)loginWithLoginParam:(YWJLoginParam *)loginParam success:(void (^)(YWJLoginResult *))success failure:(void (^)(NSError *))failure {
    NSString *urlString = [NSString stringWithFormat:@"%@user!login.action", kIOHTTPBaseUrl];
    
    //先从数据库获取数据
    YWJLoginResult *loginResult = [IOCacheTool loginResultWithLoginParam:loginParam];
    if (loginResult) {//获取成功
        if (success) {
            success(loginResult);
        }
        return ;
    } else {
        // 获取失败
        [IOHttpTool GET:urlString parameters:loginParam.mj_keyValues success:^(id responseObject) {
            YWJLoginResult *result = [YWJLoginResult mj_objectWithKeyValues:responseObject];
            if (success) {
                success(result);
            }
            // 保存到数据库
            [IOCacheTool saveUserInfoWithLoginParam:loginParam andLoginResult:result];
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
