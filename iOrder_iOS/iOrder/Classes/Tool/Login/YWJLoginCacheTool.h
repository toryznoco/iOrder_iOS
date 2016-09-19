//
//  YWJLoginCacheTool.h
//  iOrder
//
//  Created by 易无解 on 9/19/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YWJLoginParam;

@interface YWJLoginCacheTool : NSObject

/**
 *  保存登录时的账号和密码
 *
 *  @param loginParam 登录时的账号和密码
 */
+ (void)saveWithLoginParam:(YWJLoginParam *)loginParam;

+ (NSArray *)loginParams;

@end
