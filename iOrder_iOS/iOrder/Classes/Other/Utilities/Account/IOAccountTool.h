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
 检查RefreshToken是否过期

 @return YES为有效，NO为无效(1.没有，2.有但是过期)
 */
+ (BOOL)checkIfRefreshTokenValid;

/**
 保存accessToken

 @param accessToken accessToken30分钟过期
 */
+ (void)saveAccessToken:(NSString *)accessToken;


/**
 保存refreshToken

 @param refreshToken refreshToken
 */
+ (void)saveRefreshToken:(NSString *)refreshToken;

@end
