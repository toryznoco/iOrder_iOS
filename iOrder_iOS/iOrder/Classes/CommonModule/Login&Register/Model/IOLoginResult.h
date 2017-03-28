//
//  IOLoginResult.h
//  iOrder
//
//  Created by Tory on 27/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseResult.h"

@interface IOLoginResult : IOHTTPBaseResult

/**
 接口调用凭据
 */
@property (nonatomic, strong) NSString *accessToken;

/** AccessToken有效时间 */
@property (nonatomic, assign) double accessTokenValidTime;

/**
 用于获取Access Token
 */
@property (nonatomic, strong) NSString *refreshToken;

/** RefreshToken有效时间 */
@property (nonatomic, assign) double refreshTokenValidTime;

@end
