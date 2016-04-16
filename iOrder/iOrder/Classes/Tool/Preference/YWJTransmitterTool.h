//
//  YWJTransmitterTool.h
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWJTransmitterTool : NSObject

+ (void)saveTransmitter:(NSArray *)transmitters;
+ (NSMutableArray *)transmitters;

@end
