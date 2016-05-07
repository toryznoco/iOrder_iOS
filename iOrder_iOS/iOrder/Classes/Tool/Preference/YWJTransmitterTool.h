//
//  YWJTransmitterTool.h
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//  储存和获取Transmitter

#import <Foundation/Foundation.h>

@interface YWJTransmitterTool : NSObject

/**
 *  储存Transmitter
 *
 *  @param transmitters Transmitter
 */
+ (void)saveTransmitter:(NSArray *)transmitters;

/**
 *  获取Transmitter
 *
 *  @return Transmitter
 */
+ (NSMutableArray *)transmitters;

@end
