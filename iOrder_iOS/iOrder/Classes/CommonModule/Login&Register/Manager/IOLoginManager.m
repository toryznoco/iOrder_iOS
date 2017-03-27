//
//  IOLoginManager.m
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOLoginManager.h"
#import "IONetworkTool.h"
#import "IOLoginParam.h"

#define kIOHTTPLoginUrl @"app/customer/login"

@implementation IOLoginManager

+ (void)loginWithParam:(IOLoginParam *)param
               success:(void (^)(NSDictionary * _Nullable result))success
               failure:(void (^)(NSError * _Nonnull error))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPLoginUrl];
    [IONetworkTool POST:urlStr parameters:param.mj_keyValues success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObj) {
        success(responseObj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
