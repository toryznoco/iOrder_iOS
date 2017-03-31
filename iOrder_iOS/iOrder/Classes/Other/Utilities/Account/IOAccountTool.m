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
    // 先判断有没有accessToken，没有则无效
    if (![IOUserDefaults objectForKey:kIOAccessTokenKey]) return NO;
    
    // 拿到过期时间，精确到分钟
    NSDate *expiredDate = [IOUserDefaults objectForKey:kIOAccessTokenExpiredTimeKey];
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyyMMddHHmm";
    NSString *expiredTime = [fmt stringFromDate:expiredDate];
    IOLog(@"AccessToken过期时间%ld", expiredTime.integerValue);
    
    // 和当前时间作比较，
    NSDate *date = [NSDate date];
    NSString *currentTime = [fmt stringFromDate:date];
    IOLog(@"%ld", currentTime.integerValue);
    
    if (expiredTime.integerValue >= currentTime.integerValue) {
        // 过期时间大于当前时间，没过期，有效
        return YES;
    } else {
        return NO;
    }
}

/**
 检查RefreshToken是否过期
 
 @return YES为有效，NO为无效(1.没有，2.有但是过期)
 */
+ (BOOL)checkIfRefreshTokenValid {
    // 先判断有没有refreshToken，没有则无效
    if (![IOUserDefaults objectForKey:kIORefreshTokenKey]) return NO;
    
    // 拿到过期时间，精确到日
    NSDate *expiredDate = [IOUserDefaults objectForKey:kIORefreshTokenExpiredTimeKey];
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyyMMdd";
    NSString *expiredTime = [fmt stringFromDate:expiredDate];
    IOLog(@"RefreshToken过期时间%ld", expiredTime.integerValue);
    
    // 和当前时间作比较，
    NSDate *date = [NSDate date];
    NSString *currentTime = [fmt stringFromDate:date];
    IOLog(@"%ld", currentTime.integerValue);
    
    if (expiredTime.integerValue >= currentTime.integerValue) {
        // 过期时间大于当前时间，没过期，有效
        return YES;
    } else {
        return NO;
    }
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
    [IOUserDefaults setObject:date forKey:kIOAccessTokenExpiredTimeKey];
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
    [IOUserDefaults setObject:date forKey:kIORefreshTokenExpiredTimeKey];
}

/**
 获取本地保存的refreshToken
 */
+ (NSString *)refreshToken {
    return [IOUserDefaults objectForKey:kIORefreshTokenKey];
    
}

/**
 获取本地保存的accessToken
 */
+ (NSString *)accessToken {
    return [IOUserDefaults objectForKey:kIOAccessTokenKey];
}

@end
