//
//  IOLoginParam.h
//  iOrder
//
//  Created by Tory on 27/03/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOLoginParam : NSObject

/**
 用户名
 */
@property (nonatomic, strong) NSString *account;

/**
 用户密码
 */
@property (nonatomic, strong) NSString *password;

@end
