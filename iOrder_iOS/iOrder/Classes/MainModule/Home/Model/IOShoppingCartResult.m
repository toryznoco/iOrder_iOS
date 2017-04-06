//
//  IOShoppingCartResult.m
//  iOrder
//
//  Created by 易无解 on 05/04/2017.
//  Copyright © 2017 normcore. All rights reserved.
//

#import "IOShoppingCartResult.h"

@implementation IOShoppingCartResult

@end

@implementation IOShoppingCartItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"itemId" : @"id"
             };
}

@end
