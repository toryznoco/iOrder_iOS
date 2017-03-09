//
//  YWJVersionTool.m
//  iOrder
//
//  Created by 易无解 on 4/11/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "YWJVersionTool.h"

@implementation YWJVersionTool

+ (void)saveVersion:(NSString *)version {
    [IOUserDefaults setObject:version forKey:kVersionKey];
    [IOUserDefaults synchronize];
}

+ (NSString *)savedVersion {
    return [IOUserDefaults objectForKey:kVersionKey];
}

@end
