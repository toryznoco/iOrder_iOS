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

@implementation YWJLoginTool

+ (void)loginWithLoginParam:(YWJLoginParam *)loginParam success:(void (^)(YWJLoginResult *))success failure:(void (^)(NSError *))failure {
    NSString *urlString = [NSString stringWithFormat:@"%@user!login.action", kBackStageServerPath];
    
    [IOHttpTool GET:urlString parameters:loginParam.mj_keyValues success:^(id responseObject) {
        YWJLoginResult *result = [YWJLoginResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
