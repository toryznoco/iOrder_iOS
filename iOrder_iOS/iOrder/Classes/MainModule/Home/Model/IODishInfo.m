//
//  IODishInfo.m
//  iOrder
//
//  Created by 易无解 on 4/29/16.
//  Copyright © 2016 normcore. All rights reserved.
//

#import "IODishInfo.h"


#pragma mark - implementation IODishInfo
@implementation IODishInfo

@end


#pragma mark - implementation IODish
@implementation IODish

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"goodsId" : @"id"
             };
}

@end


#pragma mark - implementation IODishes
@implementation IODishes

@end

@implementation IODishCategory

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"categoryId" : @"id",
             @"desc" : @"description"
             };
}

@end
