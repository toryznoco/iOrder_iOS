//
//  YWJHistoryUUIDTool.m
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJHistoryUUIDTool.h"

@implementation YWJHistoryUUIDTool

+ (void)saveHistoryUUID:(NSArray *)historyUUIDs{
    [YWJUserDefaults setObject:historyUUIDs forKey:kHistoryUUIDKey];
    [YWJUserDefaults synchronize];
}

+ (NSMutableArray *)historyUUIDs{
    return (NSMutableArray *)[YWJUserDefaults arrayForKey:kHistoryUUIDKey];
}

@end
