//
//  IOOrderGenerateResult.m
//  iOrder
//
//  Created by 易无解 on 07/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOOrderGenerateResult.h"

@implementation IOOrderGenerateResult

@end

@implementation IOOrderInfo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"orderId" : @"id"
             };
}

@end
