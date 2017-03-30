//
//  IOHTTPBaseParam.h
//  iOrder
//
//  Created by Tory on 27/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOHTTPBaseParam : NSObject

/**
 token，接口调用凭据，有效时间30分钟
 */
@property (nonatomic, strong) NSString *token;

@end
