//
//  IOAccessTokenResult.h
//  iOrder
//
//  Created by Tory on 30/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOHTTPBaseResult.h"

@interface IOAccessTokenResult : IOHTTPBaseResult
/** accessToken */
@property (nonatomic, strong) NSString *accessToken;

/** 有效时长 */
@property (nonatomic, assign) NSInteger accessTokenTTL;

@end
