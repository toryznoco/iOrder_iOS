//
//  IOOrdersManager.m
//  iOrder
//
//  Created by Tory on 24/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOOrdersManager.h"
#import "IONetworkTool.h"

#define kIOHTTPOrderListUrl @"app/order/list"

@implementation IOOrdersManager

+ (void)loadNewOrdersSuccess:(void (^)(NSArray<IOOrder *> * _Nullable orders))success
                     failure:(void (^)(NSError * _Nonnull error))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kIOHTTPBaseUrl, kIOHTTPOrderListUrl];
    
    
//    [IONetworkTool GET:urlStr parameters: success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable obj) {
//        success(obj);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure(error);
//    }];
}

@end
