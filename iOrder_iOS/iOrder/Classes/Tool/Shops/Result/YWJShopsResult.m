//
//  YWJShopsResult.m
//  iOrder
//
//  Created by 易无解 on 5/9/16.
//  Copyright © 2016 易无解. All rights reserved.
//

#import "YWJShopsResult.h"

#import "IOShop.h"

@implementation YWJShopsResult

//模型转字典
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"shops":[IOShop class]};
}

@end
