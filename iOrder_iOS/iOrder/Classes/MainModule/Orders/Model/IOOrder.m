//
//  IOOrder.m
//  iOrder
//
//  Created by Tory on 16/5/11.
//  Copyright © 2016年 normcore. All rights reserved.
//

#import "IOOrder.h"

@implementation IOOrder

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"orderId": @"id"
             };
}

@end
