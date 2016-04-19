//
//  YWJTransmitterTool.m
//  iOrder
//
//  Created by 易无解 on 4/10/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJTransmitterTool.h"

@implementation YWJTransmitterTool

+ (void)saveTransmitter:(NSArray *)transmitters{
    [YWJUserDefaults setObject:transmitters forKey:kTransmitterKey];
    [YWJUserDefaults synchronize];
}

+ (NSMutableArray *)transmitters{
    return (NSMutableArray *)[YWJUserDefaults arrayForKey:kTransmitterKey];
}

@end
