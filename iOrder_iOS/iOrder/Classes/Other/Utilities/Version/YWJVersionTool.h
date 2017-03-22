//
//  YWJVersionTool.h
//  iOrder
//
//  Created by 易无解 on 4/11/16.
//  Copyright © 2016 normcore. All rights reserved.
//  储存和获取程序当前的版本号

#import <Foundation/Foundation.h>

@interface YWJVersionTool : NSObject

/**
 *  储存程序当前的版本号
 *
 *  @param version 版本号
 */
+ (void)saveVersion:(NSString *)version;

/**
 *  获保存的版本号
 *
 *  @return 返回保存的版本号
 */
+ (NSString *)savedVersion;

@end
