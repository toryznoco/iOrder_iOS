//
//  IORegisterManager.h
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IORegisterParam;
@class IORegisterResult;

@interface IORegisterManager : NSObject

/**
 注册
 
 @param param 参数
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)registerWithParam:(IORegisterParam *)param
               success:(void (^)(IORegisterResult * _Nullable result))success
               failure:(void (^)(NSError * _Nonnull error))failure;

@end
