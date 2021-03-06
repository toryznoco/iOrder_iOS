//
//  IOLoginManager.h
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IOLoginParam;
@class IOLoginResult;

@interface IOLoginManager : NSObject


/**
 登录

 @param param 参数
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)loginWithParam:(IOLoginParam *)param
               success:(void (^)(IOLoginResult * _Nullable result))success
               failure:(void (^)(NSError * _Nonnull error))failure;


@end
