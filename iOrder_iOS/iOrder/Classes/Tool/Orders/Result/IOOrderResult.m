//
//  IOOrderResult.m
//  iOrder
//
//  Created by Tory on 16/5/28.
//  Copyright © 2016年 易无解. All rights reserved.
//

#import "IOOrderResult.h"

#import "IOOrder.h"

@implementation IOOrderResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"orders":[IOOrder class]};
}

@end
