//
//  IOHomeManager.h
//  iOrder
//
//  Created by Tory on 29/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IOLoginResult;

@interface IOHomeManager : NSObject

/**
 刷新本地存储的accessToken和refreshToken

 @param success 刷新成功的回调
 @param failure 刷新失败的回调
 */
+ (void)refreshTokenSuccess:(void (^)())success
                    failure:(void (^)(NSError * _Nonnull error))failure;


+ (void)loadNearbyShopsSuccess:(void(^)(NSArray *shops))success failure:(void(^)(NSError *error))failure;

@end
