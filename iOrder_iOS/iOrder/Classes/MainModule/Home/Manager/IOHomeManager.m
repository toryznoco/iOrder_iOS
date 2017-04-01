//
//  IOHomeManager.m
//  iOrder
//
//  Created by Tory on 29/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHomeManager.h"
#import "IONetworkTool.h"
#import "IOAccountTool.h"
#import "IOLoginResult.h"
#import "IOError.h"
#import "IONearbyShopsResult.h"
#import "IOShop.h"
#import "IONearbyShopsParam.h"
#import "IOError.h"
#import "IOCacheTool.h"

#define kIOHTTPRefreshTokenUrl @"app/customer/refreshToken"
#define kIOHTTPNearbyShopsUrl @"app/shop/near"

@implementation IOHomeManager

/**
 刷新本地存储的accessToken和refreshToken
 
 @param success 刷新成功的回调
 @param failure 刷新失败的回调
 */
+ (void)refreshTokenSuccess:(void (^)())success
                    failure:(void (^)(NSError * _Nonnull error))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPRefreshTokenUrl];
    NSDictionary *param = @{@"refreshToken": [IOAccountTool refreshToken]};
    
    [IONetworkTool POST:urlStr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
        IOLoginResult *result = [IOLoginResult mj_objectWithKeyValues:responseObj];
        IOLog(@"%@", result.message);
        if (result.result == YES) {
            // 请求成功
            // 保存accessToken及过期时间，refreshToken及过期时间
            [IOAccountTool saveAccessToken:result.accessToken validTime:result.accessTokenTTL];
            [IOAccountTool saveRefreshToken:result.refreshToken validTime:result.refreshTokenTTL];
            IOLog(@"%@", @"保存成功");
            
            if (success) {
                success();
            }
        } else {
            if (failure) {
                failure([IOError errorWithCode:result.code description:@"刷新失败"]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)loadNearbyShopsSuccess:(void(^)(NSArray *shops))success failure:(void(^)(NSError *error))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPNearbyShopsUrl];
    IONearbyShopsParam *param = [IONearbyShopsParam new];
    param.lng = 30.59;
    param.lat = 103.59;
    param.pageNum = 1;
    param.pageSize = 10;
    
    IONearbyShopsResult *shopsResult = [IOCacheTool shopResultWithShopParam:param];
    if (shopsResult) {
        if (success) {
            success(shopsResult.nearShops);
        }
        return ;
    } else {
        [IONetworkTool tokenGET:urlStr parameters:param.mj_keyValues success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObj) {
            IONearbyShopsResult *result = [IONearbyShopsResult mj_objectWithKeyValues:responseObj];
            if (result.result) {
                if (success) {
                    success(result.nearShops);
                }
                [IOCacheTool saveShopInfoWithShopParam:param andShopResult:responseObj];
            } else {
                IOLog(@"%@", result.message);
                if (failure) {
                    failure([IOError errorWithCode:result.code description:@"获取失败"]);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
