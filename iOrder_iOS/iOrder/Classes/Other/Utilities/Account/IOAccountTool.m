//
//  IOAccountTool.m
//  iOrder
//
//  Created by Tory on 23/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOAccountTool.h"

@implementation IOAccountTool

/**
 检查AccessToken是否有效
 
 @return YES为有效，NO为无效(1.没有，2.有但是过期)
 */
+ (BOOL)checkIfAccessTokenValid {
    // 拿到过期时间
    NSDate *expiredDate = [IOUserDefaults objectForKey:kIOAccessTokenValidityKey];
    // 和当前时间作比较，精确到分钟
    NSDate *date = [NSDate date];
    
    return NO;
}

/**
 检查RefreshToken是否过期
 
 @return YES为有效，NO为无效(1.没有，2.有但是过期)
 */
+ (BOOL)checkIfRefreshTokenValid {
    // 拿到过期时间
    NSDate *expiredDate = [IOUserDefaults objectForKey:kIORefreshTokenValidityKey];
    // 和当前时间作比较，精确到日
    NSDate *date = [NSDate date];
    
    return NO;
}

/**
 保存accessToken和过期时间

 @param accessToken accessToken
 @param time 有效时间
 */
+ (void)saveAccessToken:(NSString *)accessToken validTime:(NSTimeInterval)time {
    // 保存accessToken
    [IOUserDefaults setObject:accessToken forKey:kIOAccessTokenKey];
    
    // 保存accessToken过期时间
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time];
    
    [IOUserDefaults setObject:date forKey:kIOAccessTokenValidityKey];
}

/**
 保存refreshToken和过期时间

 @param refreshToken refreshToken
 @param time 有效时间
 */
+ (void)saveRefreshToken:(NSString *)refreshToken validTime:(NSTimeInterval)time {
    // 保存refreshToken
    [IOUserDefaults setObject:refreshToken forKey:kIORefreshTokenKey];
    
    // 保存refreshToken过期时间
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time];
    
    [IOUserDefaults setObject:date forKey:kIORefreshTokenValidityKey];
}

@end
