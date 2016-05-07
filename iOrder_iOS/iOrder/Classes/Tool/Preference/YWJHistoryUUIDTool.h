//
//  YWJHistoryUUIDTool.h
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//  储存和获取UUID历史记录

#import <Foundation/Foundation.h>

@interface YWJHistoryUUIDTool : NSObject

/**
 *  当UUID有变化时，储存UUID历史记录
 *
 *  @param historyUUIDs UUID历史记录
 */
+ (void)saveHistoryUUID:(NSArray *)historyUUIDs;

/**
 *  获取UUID历史记录
 *
 *  @return UUID历史记录
 */
+ (NSMutableArray *)historyUUIDs;

@end
