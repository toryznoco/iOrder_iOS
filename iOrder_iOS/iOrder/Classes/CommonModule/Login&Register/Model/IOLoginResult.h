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
 接口调用凭据，有效时间30分钟
 */
@property (nonatomic, strong) NSString *accessToken;

/**
 用于获取Access Token，3天不访问后台过期
 */
@property (nonatomic, strong) NSString *refreshToken;

@end
