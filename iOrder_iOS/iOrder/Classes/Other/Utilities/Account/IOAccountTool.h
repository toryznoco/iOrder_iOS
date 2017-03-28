//
//  IOAccountTool.h
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOAccountTool : NSObject

/**
 检查AccessToken是否有效
 
 @return YES为有效，NO为无效(1.没有，2.有但是过期)
 */
+ (BOOL)checkIfAccessTokenValid;

/**
 检查RefreshToken是否有效

 @return YES为有效，NO为无效(1.没有，2.有但是过期)
 */
+ (BOOL)checkIfRefreshTokenValid;

/**
 保存accessToken和过期时间
 
 @param accessToken accessToken
 @param time 有效时间
 */
+ (void)saveAccessToken:(NSString *)accessToken validTime:(NSTimeInterval)time;

/**
 保存refreshToken和过期时间
 
 @param refreshToken refreshToken
 @param time 有效时间
 */
+ (void)saveRefreshToken:(NSString *)refreshToken validTime:(NSTimeInterval)time;

@end
